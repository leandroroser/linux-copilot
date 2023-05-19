function print_executable() {
  echo -e "\e[1;35mPress enter to run or 'q' to exit\e[0m"
  if [ "$BASH_VERSION" ]; then
    read -e -i "$1" -p ">> " command
  elif [ "$ZSH_VERSION" ]; then
    vared -p ">> " -c -i "$1" command
  else
    echo "Unsupported shell. Please use Bash or Zsh."
    exit 1
  fi

  if [ "$command" = "q" ]; then
    echo $'\e[1;35mExiting...\e[0m'
    exit 0
  fi

  if [ -n "$command" ]; then
    eval "$command"
  else
    echo $'\e[1;35mInvalid input. Exiting...\e[0m'
  fi
}

function dummy_chat() {
  x=$(curl -s -X POST -H "Content-Type: application/json" -d '{"data":"'"$1"'"}' http://localhost:8000/)
  result=$(echo "$x" | jq -r '.result')
  if [ -n "$result" ]; then
    print_executable "$result"
  else
    echo '\e[1;35mSorry, I dont know how to respond your question\e[0m'
  fi
}

function eval_loop() {
  echo -e "\e[1;35mHey, what can I help you with today?\e[0m"
  while true; do
    if [ "$BASH_VERSION" ]; then
      read -r -p $'Write your question or press \'q\' to exit\n\e[1;32m>\e[0m ' input
    elif [ "$ZSH_VERSION" ]; then
      vared -p $'Write your question or press \'q\' to exit\n\e[1;32m>\e[0m ' -c input
    else
      echo "Unsupported shell. Please use Bash or Zsh."
      exit 1
    fi

    echo "Your input is: $input"
    if [ "$input" = "q" ]; then
      echo $'\e[1;35mExiting...\e[0m'
      break
    fi
    dummy_chat "$input"
  done
}

eval_loop
