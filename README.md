# work
Hourly work logger with support for recording payments and generating statements of account

## How it works

I have iOS/macOS shortcuts that I use to log my hours and log payment receipts to text file. Another shortcut syncs this to my server. 

The code in this repo copies in the logs, and processes the data

I have written the minimal amount of code to get paid, but have set the repo up so that I can build out invoicing, statements of account etc if needed.

## How to use it

Clone in the repo, `cd` into it, and run `make` for help.

```bash
$ make

build                          Build docker container with required dependencies and data
build-debug                    Build docker debug container with required dependencies
clean                          Remove build files
debug                          Launch an interactive environment
get-data                       Copy in work and payments files from remote location
help                           Show available targets
run                            Process the files
test                           Run tests
```
