[![CodeQL](https://github.com/philips-software/Repo-Secret-Manager/actions/workflows/codeql-analysis.yml/badge.svg?event=push)](https://github.com/philips-software/Repo-Secret-Manager/actions/workflows/codeql-analysis.yml) [![Tests](https://github.com/philips-software/Repo-Secret-Manager/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/philips-software/Repo-Secret-Manager/actions/workflows/ci.yml)
# Repo Secret Manager Action
This action can be used to automate creating, updating, and deleting repository level [GitHub secrets](https://docs.github.com/en/actions/reference/encrypted-secrets) for repos belonging to a user or a team which are generated using a particular template repo, leveraging GitHub's existing encrypted storage. 

Currently, GitHub does not support storing secrets at the team level, only at the repository or organization level. This is inconvenient in case a team manages many repositories, as the secrets would otherwise need to be manually added to each repo or exposed to the entire organization.

## Parameters
**If no command-line arguments are provided, the tool will prompt for each value**
| Command | Description | Mandatory? |
| ---- | ---- | ---- |
|action|The action to be performed-  "create", "update", or "delete". If `create` is selected and the secret(s) already exist for a repo, they will not be updated. If `update` is selected, existing secrets will be updated to the new value. If a repository is missing a secret, it will be added. add If `delete` is selected and the secret does not exist it will not cause issues | Yes, as the first argument |
|token| A [GitHub PAT](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with permission to manage secrets. Can NOT be the GITHUB_TOKEN secret.| Yes |
|secret-names| A comma-separated list of secret name(s) to apply the action to | Yes |
|secret-values| A comma-separated list of secret value(s)| If "create" or "update" is selected |
|team|If a team name is given, the secret will be added to all repositories in that team. If no team is specified, the secret will be added to all of the user's repositories|No|
|templateRepo| Template repo which is truth for the secrets.|Yes|

## Usage
### Add Secret(s)
```yaml
- name: Add Secret
  uses: philips-software/Repo-Secret-Manager@main
  with:
    action: create
    token: ${{ secrets.MY_GITHUB_PAT }}
    secret-names: BLACKDUCK_TOKEN
    secret-values: abc123
    templateRepo: "myTemplateRepoName"
    
- name: Add Secrets to HELLO team Repos
  uses: philips-software/Repo-Secret-Manager@main
  with:
    action: create
    token: ${{ secrets.MY_GITHUB_PAT }}
    secret-names: BLACKDUCK_TOKEN,FORTIFY_TOKEN
    secret-values: abc123,123abc
    team: hello
    templateRepo: "myTemplateRepoName"
    
```
### Update Existing Secret(s) with New Value
```yaml
- name: Update Secret
  uses: philips-software/Repo-Secret-Manager@main
  with:
    action: update
    token: ${{ secrets.MY_GITHUB_PAT }}
    secret-names: BLACKDUCK_TOKEN
    secret-values: xyz123
    templateRepo: "myTemplateRepoName"
```

### Delete Secret(s)
```yaml
- name: Delete Secret
  uses: philips-software/Repo-Secret-Manager@main
  with:
    action: delete
    token: ${{ secrets.MY_GITHUB_PAT }}
    secret-names: BLACKDUCK_TOKEN
    templateRepo: "myTemplateRepoName"
```


