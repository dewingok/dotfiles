function ossl() {
  echo | openssl s_client -connect ${1}:443
}

