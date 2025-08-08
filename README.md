To get rid of leaks:

```
gitleaks detect --source . \
  --report-format=json \
  --report-path=gitleaks.json
```

```
git filter-repo --replace-text leaks.txt --force\n
```

```
jq -r '
  map(.Secret)            # pull all "Secret" fields
  | unique                # de-duplicate
  | .[]                   # each secret
  | "literal:" + . + "==>REDACTED"
' gitleaks.json > leaks.txt
```
