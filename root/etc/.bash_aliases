alias home="cd /var/www"

#general
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias h="history"
alias c="composer"
alias g="git"
alias ll="ls -l"
alias la="ls -la"

#flow
alias f='./flow'
alias fh='./flow help'
alias flow="./flow"
alias fcf='flow flow:cache:flush'
alias fcff='flow flow:cache:flush --force'
alias fcw='flow cache:warmup'
alias fcffw='fcff; fcw'
alias fcv="flow configuration:validate —type"