function command_exists () {
  type "$1" &> /dev/null;
}

function ossl() {
  echo | openssl s_client -connect ${1}:443
}

