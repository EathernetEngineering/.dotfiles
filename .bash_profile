#!/usr/bin/env bash

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='0;32'
# grep 2.9+
export GREP_COLORS="ms=00;32:mc=01;31:sl=:cx=:fn=01;34:ln=0;33:bn=32:se=36"
export CLICOLOR=1

if ls --color -d . >/dev/null 2>&1; then
  export GNU_LS=1
  export LS_OPTIONS=--color=auto
  eval `dircolors -b ~/.dir_colors`
elif ls -G -d . >/dev/null 2>&1; then
  export BSD_LS=1
  export LS_OPTIONS=-G
  export LSCOLORS=ExFxCxDxBxegedabagacad
fi

# ls aliases
alias l='ls $LS_OPTIONS -lh'
alias la='ls $LS_OPTIONS -lAh'
alias ld='ls $LS_OPTIONS -lad */'
alias lf='ls $LS_OPTIONS -ap | grep -v /'
##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################

bash_prompt_command() {
  # RETURN=$?
  # How many characters of the $PWD should be kept
  local pwdmaxlen=45
  # Indicate that there has been dir truncation
  local trunc_symbol=".."
  local dir=${PWD##*/}
  pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
  NEW_PWD=${PWD/#$HOME/\~}
  local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
  if [ ${pwdoffset} -gt "0" ]
  then
    NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
    NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
  fi
  history -a
  #EXIT_CODE='$(if [[ $RETURN = 0 ]]; then echo -ne ""; else echo -ne "\[$EMR\]$RETURN\[$NONE\] "; fi;)'
}

PROMPT_VCS=1 # version control system name, branch and dirty status

prompt.vcs.enable(){
  PROMPT_VCS=1
}
prompt.vcs.disable(){
  PROMPT_VCS=0
}
vcs(){
  [ $PROMPT_VCS -eq "1" ] && echo -e "$(vcprompt -f "${K} %n[${R}%b${EMG}%m${EMR}%u${K}]")"
}

bash_prompt() {
  case $TERM in
    xterm*|rxvt*)
      local TITLEBAR='\[\033]0;${SHORT_HOST} ${NEW_PWD}\007\]'
      ;;
    *)
    local TITLEBAR=""
    ;;
  esac

  local UC=$W                    # user's color
  [ $UID -eq 0 ] && UC=$EMR      # root's color

  local ARROW_COLOR=$EMR
  [ $? -eq 0 ] && ARROW_COLOR=$EMG

  PS1="\[${TITLEBAR}\
${UC}\u\
\$(vcs) \
${EMB}\${NEW_PWD} \
${K} \
\[${NONE}\]\n\[${ARROW_COLOR}\]→ \[${NONE}\]"

}

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} bash_prompt_command"
bash_prompt

test -f ~/.bashrc && . $_


[ -s "/home/chloe/.svm/svm.sh" ] && source "/home/chloe/.svm/svm.sh"
