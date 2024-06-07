# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"
# ZSH_THEME="obraun"
# ZSH_THEME="xiong-chiamiov"
# ZSH_THEME="minimal"
# ZSH_THEME="agnoster"
# ZSH_THEME="frontcube"
ZSH_THEME="powerlevel10k/powerlevel10k"

# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

####################### Previous .zshrc configuration #######################

#Set up the prompt with username, hostname, and git branch information
# autoload -Uz vcs_info
# zstyle ':vcs_info:git:*' formats '%F{92}[%F{92}%b]'
# precmd() { vcs_info }
# setopt PROMPT_SUBST
# # PROMPT='%F{205}%B%n@%m%b%f%B%F{247}::%F{187}%~%b%f%f
# # ${vcs_info_msg_0_}%F{cyan}➤%f '

# # same prompt but without git branch
# PROMPT='%F{205}%B%n@%m%b%f%B%F{247}::%F{187}%~%b%f%f
# %F{cyan}➤%f '

# # Alias to add color to ls
# alias ls='ls --color=auto'

# # Alias to add color to grep
# alias grep='grep --color=auto'

# # Set up LS_COLORS to colorize ls output
# LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
# export LS_COLORS

# llfo = link libs from onedrive
ldl() {
    sudo /home/jmoore2/system_libs_unlink_link/system_libs_link_and_unlink/link_libs.sh --path "$1"
}

# Function to unlink libs with a dynamic path argument
uldl() {
    sudo /home/jmoore2/system_libs_unlink_link/system_libs_link_and_unlink/unlink_libs.sh --path "$1"
}

lh() {
    sudo /home/jmoore2/system_includes_unlink_link/link_headers.sh --path "$1"
}

ulh() {
    sudo /home/jmoore2/system_includes_unlink_link/unlink_headers.sh --path "$1"
}

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word

setopt INC_APPEND_HISTORY # save to history after each command is executed
setopt APPEND_HISTORY # save to history after shell exits, whatever is not
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

LINUX_CONFIG_PATH=~/OneDrive/Misc/linux_config

alias xclip='xclip -selection clipboard'

# >>> conda initialize >>>
if [ -f "/opt/mambaforge/etc/profile.d/conda.sh" ]; then
    . "/opt/mambaforge/etc/profile.d/conda.sh"
else
    export PATH="/opt/mambaforge/bin:$PATH"
fi

if [ -f "/opt/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/opt/mambaforge/etc/profile.d/mamba.sh"
else
    export PATH="/opt/mambaforge/bin:$PATH"
fi

# <<< conda initialize <<<

eval "$(zoxide init zsh)"
