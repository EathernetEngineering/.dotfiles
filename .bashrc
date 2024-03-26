#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias rm='rm --verbose'
PS1='[\u@\h \W]\$ '


mkdir -p /tmp/ccls/cache

export PATH="/usr/i686elfgcc/bin:/usr/x86_64elfgcc/bin:/usr/i386elfgcc/bin:/opt/NVIDIA_Nsight_Aftermath_SDK_2023.3.0.23325/include:/home/chloe/.local/bin:$PATH"
export LD_LIBRARY_PATH="/opt/NVIDIA_Nsight_Aftermath_SDK_2023.3.0.23325/lib/x64:/usr/local/lib:$LD_LIBRARY_PATH"

eval $(keychain --quiet --eval github_key)

export GPG_TTY=$(tty)

[ -s "/home/chloe/.svm/svm.sh" ] && source "/home/chloe/.svm/svm.sh"

