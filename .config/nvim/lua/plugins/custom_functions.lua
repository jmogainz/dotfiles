local M = {}

M.create_cpp_definition = function()
    -- Get the current buffer and cursor position
    local bufnr = vim.api.nvim_get_current_buf()
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_buf_get_lines(bufnr, pos[1] - 1, pos[1], false)[1]

    -- Extract the function signature
    local function_signature = line:match("%s*(.-);")
    if not function_signature then
        vim.notify("No valid function signature found on the current line", vim.log.levels.ERROR)
        return
    end

    -- Extract the class name if it exists
    local class_name = nil
    local prev_line_nr = pos[1] - 2
    while prev_line_nr >= 0 do
        local prev_line = vim.api.nvim_buf_get_lines(bufnr, prev_line_nr, prev_line_nr + 1, false)[1]
        class_name = prev_line:match("class%s+([%w_]+)%s*")
        if class_name then break end
        prev_line_nr = prev_line_nr - 1
    end

    -- Extract the namespace if it exists
    local namespaces = {}
    prev_line_nr = pos[1] - 2
    while prev_line_nr >= 0 do
        local prev_line = vim.api.nvim_buf_get_lines(bufnr, prev_line_nr, prev_line_nr + 1, false)[1]
        local namespace = prev_line:match("namespace%s+([%w_]+)%s*{")
        if namespace then
            table.insert(namespaces, 1, namespace)
        end
        prev_line_nr = prev_line_nr - 1
    end

    -- Add the class scope to the function definition if a class was found
    local function_definition
    if class_name then
        local return_type, function_name = function_signature:match("^(.-)%s+([%w_~]+)%s*%b()")
        if not return_type then
            function_name = function_signature:match("([%w_~]+)%s*%b()")
            return_type = ""
        end
        function_definition = return_type .. (return_type ~= "" and " " or "") .. class_name .. "::" .. function_name .. function_signature:match("%b()") .. "\n{\n    // TODO: implement\n}\n"
    else
        function_definition = function_signature .. "\n{\n    // TODO: implement\n}\n"
    end

    -- Add namespace scopes to the function definition
    if #namespaces > 0 then
        local namespace_scope = table.concat(namespaces, "::") .. "::"
        function_definition = return_type .. " " .. (return_type ~= "" and " " or "") .. namespace_scope .. (class_name and (class_name .. "::") or "") .. function_name .. function_signature:match("%b()") .. "\n{\n    // TODO: implement\n}\n"
    end

    -- Find the corresponding .cpp file
    local header_file = vim.api.nvim_buf_get_name(bufnr)
    local Path = require('plenary.path')
    local scan = require('plenary.scandir')

    local function find_source_file(project_root, source_base_name)
        local found_files = {}

        scan.scan_dir(project_root, {
            depth = 10,
            search_pattern = source_base_name,
            on_insert = function(entry)
                table.insert(found_files, entry)
            end,
        })
        return found_files
    end

    -- Function to create search paths
    local function create_search_paths(header_file)
        local base_name = header_file:match("([^/]+)$")
        local source_base_name = base_name:gsub("%.h$", ".cpp"):gsub("%.hpp$", ".cpp")
        local dir_name = header_file:match("(.*/)")

        -- Assume the project root is a few levels up from the source file directory
        local project_root = Path:new(dir_name):parent():parent():parent().filename
        local found_files = find_source_file(project_root, source_base_name)

        -- Convert all paths to absolute paths
        for i, path in ipairs(found_files) do
            found_files[i] = vim.fn.fnamemodify(path, ":p")
        end

        return found_files
    end

    local search_paths = create_search_paths(header_file)
    local found_source_file = nil
    for _, path in ipairs(search_paths) do
        if vim.fn.filereadable(path) == 1 then
            found_source_file = path
            break
        end
    end

    if not found_source_file then
        vim.notify("No corresponding source file found", vim.log.levels.ERROR)
        return
    end

    -- Write the function definition to the .cpp file
    local append_to_cpp = function()
        local cpp_bufnr = vim.fn.bufnr(found_source_file, true)
        if cpp_bufnr == -1 then
            vim.notify("Could not open corresponding .cpp file", vim.log.levels.ERROR)
            return
        end

        -- Check if the definition already exists
        local cpp_lines = vim.api.nvim_buf_get_lines(cpp_bufnr, 0, -1, false)
        for _, cpp_line in ipairs(cpp_lines) do
            if cpp_line:match(function_signature) then
                vim.notify("Function definition already exists in the .cpp file", vim.log.levels.WARN)
                return
            end
        end

        -- Append the function definition to the end of the .cpp file if no namespace found
        vim.api.nvim_buf_set_lines(cpp_bufnr, -1, -1, false, vim.split(function_definition, '\n'))

    end

    -- Switch to the .cpp file buffer and append the function definition
    vim.cmd("edit " .. found_source_file)
    append_to_cpp()
end

M.create_cpp_declaration = function()
    -- Get the current buffer and cursor position
    local bufnr = vim.api.nvim_get_current_buf()
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_buf_get_lines(bufnr, pos[1] - 1, pos[1], false)[1]

    -- Extract the function definition
    local function_definition = line:match("^(.-)%s*{") or line:match("^(.-)%s*$")
    if not function_definition then
        vim.notify("No valid function definition found on the current line", vim.log.levels.ERROR)
        return
    end

    -- Extract the return type, class name, and function signature
    local return_type, class_name, function_signature = function_definition:match("^(.-)%s+(.-)::(.-%b())")
    if not function_signature then
        return_type, function_signature = function_definition:match("^(.-)%s+(.-%b())")
    end
    if not function_signature then
        vim.notify("No valid function signature found in the definition", vim.log.levels.ERROR)
        return
    end

    local function_declaration = return_type .. " " .. function_signature .. ";"

    -- Find the corresponding header file
    local cpp_file = vim.api.nvim_buf_get_name(bufnr)
    local Path = require('plenary.path')
    local scan = require('plenary.scandir')

    local function find_header_file(project_root, header_base_name)
        local found_files = {}
        scan.scan_dir(project_root, {
            depth = 10,
            search_pattern = header_base_name,
            on_insert = function(entry)
                table.insert(found_files, entry)
            end,
        })
        return found_files
    end

    local function create_search_paths(source_file)
        local base_name = source_file:match("([^/]+)$")
        local header_base_name = base_name:gsub("%.cpp$", ".h"):gsub("%.cpp$", ".hpp")
        local dir_name = source_file:match("(.*/)")

        -- Assume the project root is a few levels up from the source file directory
        local project_root = Path:new(dir_name):parent():parent().filename
        local found_files = find_header_file(project_root, header_base_name)

        -- Convert all paths to absolute paths
        for i, path in ipairs(found_files) do
            found_files[i] = vim.fn.fnamemodify(path, ":p")
        end

        return found_files
    end

    local search_paths = create_search_paths(cpp_file)
    local found_header_file = nil
    for _, path in ipairs(search_paths) do
        if vim.fn.filereadable(path) == 1 then
            found_header_file = path
            break
        end
    end

    if not found_header_file then
        vim.notify("No corresponding header file found", vim.log.levels.ERROR)
        return
    end

    -- Insert the function declaration into the header file
    local insert_declaration = function()
        local header_bufnr = vim.fn.bufnr(found_header_file, true)
        if header_bufnr == -1 then
            vim.notify("Could not open corresponding header file", vim.log.levels.ERROR)
            return
        end

        -- Find the class definition and insert the declaration
        local lines = vim.api.nvim_buf_get_lines(header_bufnr, 0, -1, false)
        local insert_line = nil
        if class_name then
            for i, l in ipairs(lines) do
                if l:match("class%s+" .. class_name) then
                    insert_line = i
                    break
                end
            end
        end

        if not insert_line then
            -- If no class is found, insert at the end of the file
            insert_line = #lines
        else
            -- Find the next line after the class definition
            for i = insert_line, #lines do
                if lines[i]:match("};") then
                    insert_line = i
                    break
                end
            end
        end

        -- Insert the function declaration
        vim.api.nvim_buf_set_lines(header_bufnr, insert_line, insert_line, false, { function_declaration })
    end

    -- Switch to the header file buffer and insert the declaration
    vim.cmd("edit " .. found_header_file)
    insert_declaration()
end

M.copy_snippet_info = function()
    local start_time = vim.loop.hrtime()

    local file = vim.fn.expand('%')
    local startline = vim.fn.line("v")
    local endline = vim.fn.line(".")
    if startline > endline then
        startline, endline = endline, startline
    end
    print(string.format("Debug: file=%s, startline=%d, endline=%d", file, startline, endline))

    local lines = vim.fn.getline(startline, endline)
    local mid_time = vim.loop.hrtime()
    print(string.format("Time to get lines: %.2f ms", (mid_time - start_time) / 1e6))

    if #lines == 0 then
        print("No lines selected")
        return
    end
    local snippet = table.concat(lines, "\n")
    local formatted = string.format("File: %s\nLines: %d-%d\n\n%s", file, startline, endline, snippet)

    local before_clipboard_time = vim.loop.hrtime()
    vim.fn.setreg('+', formatted)
    local after_clipboard_time = vim.loop.hrtime()
    print(string.format("Time to set clipboard: %.2f ms", (after_clipboard_time - before_clipboard_time) / 1e6))

    print("Snippet copied to clipboard")
    local end_time = vim.loop.hrtime()
    print(string.format("Total time: %.2f ms", (end_time - start_time) / 1e6))
end

-- Do the new function in a correct module way
M.copy_and_print_file_path = function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg('+', path) -- Copy to clipboard
    print("File path copied to clipboard: " .. path) -- Print to command line
end

M.copy_and_print_dir_path = function()
    local path = vim.fn.expand("%:p:h")
    vim.fn.setreg('+', path) -- Copy to clipboard
    print("Path copied to clipboard: " .. path) -- Print to command line
end

return M
