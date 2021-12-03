# Biller Git Hooks

## Move files

To move the hook files in this repo to your Biller project, do the following:

```sh
# clone the repository
git@github.com:jeroenbiller/git-hooks.git

# go into the newly cloned repo
cd git-hooks

# move the files to your Biller project folder
cp -r hooks/. path/to/biller-project/.git/hooks/

# make the files in hooks folder executable
chmod +x path/to/biller-project/.git/hooks/*
```

## Test files

Testing is done manually with bats.

Read more here: https://bats-core.readthedocs.io/en/stable/docker-usage.html

Sample run:

```sh
$ cd ./tests
$ bats prepare-commit-msg.bats
 ✓ correct commit message
 ✓ no capitalized sentence
 ✓ without ticket number
 ✓ ticket number with brackets
 ✓ with period at the end
 ✓ branch name prepended
 ✓ branch without ticket number

7 tests, 0 failures
```