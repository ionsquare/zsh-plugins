function p9kdefaults(){
  unset POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR
  unset POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR

  # Segments
  POWERLEVEL9K_MODE="nerdfont-complete"
  POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

  #POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir vcs)
  #POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs vi_mode time)
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time root_indicator context $P9K_PROMPT_KUBECTL dir $P9K_PROMPT_VCS background_jobs status command_execution_time vi_mode)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}\u2570\uF460%f "

  POWERLEVEL9K_SHORTEN_STRATEGY=truncate_with_package_name
  POWERLEVEL9K_DIR_PACKAGE_FILES=(powerlevel9k.json .powerlevel9k.json composer.json)
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=50

  # Colours and format
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true

  DEFAULT_USER=matthewh
  POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'
  POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='71'    # green
  POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND='yellow'
  POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='red'

  POWERLEVEL9K_DIR_HOME_FOREGROUND='38'
  POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='38'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='202'
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'

  POWERLEVEL9K_TIME_BACKGROUND='clear'
  POWERLEVEL9K_TIME_FOREGROUND='28'
  POWERLEVEL9K_TIME_ICON=''

  POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='yellow'
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1

  POWERLEVEL9K_STATUS_ERROR_BACKGROUND='black'
  POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'

  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='101'
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='0'

  POWERLEVEL9K_VI_INSERT_MODE_STRING=''
  POWERLEVEL9K_VI_COMMAND_MODE_STRING='VICMD'
  POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='blue'
}
p9kdefaults

# Add prompt segment
function p9kadd(){
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=($POWERLEVEL9K_LEFT_PROMPT_ELEMENTS $1)
  source $POWERLEVEL9K_INSTALLATION_PATH/powerlevel9k.zsh-theme
}

# Remove prompt segment
function p9kremove(){
  a=($POWERLEVEL9K_LEFT_PROMPT_ELEMENTS)
  a=("${(@)a:#$1}")
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=($a)

  echo $POWERLEVEL9K_LEFT_PROMPT_ELEMENTS

  source $POWERLEVEL9K_INSTALLATION_PATH/powerlevel9k.zsh-theme
}

# Change prompt theme
function chp(){
  # Set baseline values
  p9kdefaults
  
  # Change based on input
  case "$1" in
    paste)
      #POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="#"
      #POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="#"
      POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="»"
      POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""

      #POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}#%f"
      #POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}$%f "
      POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
      POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}\u2570»%f "
      
      POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context custom_kubectl_config dir)
      POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
      POWERLEVEL9K_HOME_ICON=''
      POWERLEVEL9K_HOME_SUB_ICON=''
      POWERLEVEL9K_FOLDER_ICON=''
      ;;
    limit)
      if [[ "$2" == [1-9] ]]; then
        POWERLEVEL9K_SHORTEN_DIR_LENGTH="$2"
      else
        POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
      fi
      POWERLEVEL9K_SHORTEN_STRATEGY="Default"
      ;;
    short)
      if [[ "$2" == [1-9] ]]; then
        POWERLEVEL9K_SHORTEN_DIR_LENGTH="$2"
      else
        POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
      fi
      ;;
    unique)
      POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
      ;;
    full)
      POWERLEVEL9K_SHORTEN_STRATEGY=None
      ;;
    normal)
      ;;
    *)
      echo "Options:"
      echo "  paste       Use minimal segments for easy pasting"
      echo "  limit [n]   Show only the last n directories (default 2)"
      echo "  short [n]   Shorten each dir to n characters (default 3)"
      echo "  unique      Set directory shortening strategy to unique"
      echo "  full        Reset to default long listing"
      echo "  normal      Reset to default long listing with project name root"
      return
      ;;
  esac

  source $POWERLEVEL9K_INSTALLATION_PATH/powerlevel9k.zsh-theme
}

