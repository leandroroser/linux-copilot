if [ -n "$ZSH_VERSION" ]; then
  PROMPT_MAGENTA='%F{magenta}'
  PROMPT_RESET='%f'
elif [ -n "$BASH_VERSION" ]; then
  PROMPT_MAGENTA='\e[1;35m'
  PROMPT_RESET='\e[0m'
else
  echo "Unsupported default shell." >&2
  exit 1
fi


chars="/-\|"
animation_delay=0.1
animate() {
  while :; do
    for ((i = 0; i < ${#chars}; i++)); do
      echo -ne "${chars:$i:1}"
      sleep $animation_delay
      echo -ne "\r"
    done
  done
}

function print_executable() {
  echo -e "${PROMPT_MAGENTA}Press enter to run or 'q' to exit${PROMPT_RESET}"
  if [ "$BASH_VERSION" ]; then
    read -e -i "$1" -p ">> " command
  elif [ "$ZSH_VERSION" ]; then
    vared -p ">> " -c -i "$1" command
  else
    echo "Unsupported shell. Please use Bash or Zsh."
    exit 1
  fi

  if [ "$command" = "q" ]; then
    echo "${PROMPT_MAGENTA}Exiting...${PROMPT_RESET}"
    exit 0
  fi

  if [ -n "$command" ]; then
    eval "$command"
  else
    echo "${PROMPT_MAGENTA}Invalid input. Exiting...${PROMPT_RESET}"
  fi
}

function dummy_chat() {
  animate &
  echo "I'm thinking..."
  x=$(curl -s -X POST -H "Content-Type: application/json" -d '{"data":"'"$1"'"}' http://localhost:8000/)
  kill $!
  result=$(echo "$x" | jq -r '.result')
  if [ -n "$result" ]; then
    print_executable "$result"
  else
    echo -e "${PROMPT_MAGENTA}Sorry, I dont know how to respond your question${PROMPT_RESET}"
  fi
}

function eval_loop() {
  while true; do
    echo -e "${PROMPT_MAGENTA}Write your question or press 'q' to exit${PROMPT_RESET}"
    if [ "$BASH_VERSION" ]; then
      read -r -p ">> " input
    elif [ "$ZSH_VERSION" ]; then
      vared -p ">> " -c input
    else
      echo "Unsupported shell. Please use Bash or Zsh."
      exit 1
    fi
    if [ "$input" = "q" ]; then
      echo -e "${PROMPT_MAGENTA}Exiting...${PROMPT_RESET}"
      break
    fi
    dummy_chat "$input"
  done
}

eval_loop
