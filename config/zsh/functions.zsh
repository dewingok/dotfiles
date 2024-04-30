command_exists () {
  type "$1" &> /dev/null;
}

ossl() {
  echo | openssl s_client -connect ${1}:443
}

