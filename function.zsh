#!/bin/zsh

function push_terminate_self_to_clipboard() {
  echo "aws ec2 terminate-instances --instance-ids \`curl http://169.254.169.254/latest/meta-data/instance-id\` --region=us-east-1" | pbcopy
}

# set terminal tab name
function tabname() {
	echo -en "\033]0; "$1" \a"
}

# npm installer helper
function npmi () {
  local packagename=$(echo ${@} | sed -E 's/(\-+[a-zA-Z0-9]+| )//g')
  local opt
  npm info ${packagename} | less
  echo "Is it the right package? (y/n)"
  read opt
  if [[ "${opt}" == "y" ]]; then
    npm i ${@}
  fi
}

function __get_aws_metadata_value() {
  local AWS_METADATA_URL="http://169.254.169.254/latest/meta-data"
  local path="$1"
  local value=$(curl -L --connect-timeout 2 -s -f $AWS_METADATA_URL/$path)

  if [[ $? -eq 0 ]]; then
    echo "$value"
  else
    echo ""
  fi
}

function removeline() {
	sed -i '' "$1"d $2
}

function load_envmgrs() {
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

  pyenv virtualenvwrapper
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
}

function getip() {
  curl ipinfo.io/ip
}
