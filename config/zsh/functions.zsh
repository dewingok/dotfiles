function activate() {
  local env=${1:-".venv"}

  if [[ ! -d "$env" ]]; then
    echo "Virtual envirnoment '$env' not found."
    return 1
  fi

  source "./$env/bin/activate"
}

function make_venv() {
  local env=${1:-".venv"}
  if [[ -d "$env" ]]; then
    echo "Virtual environment '$env' already exists."
    return 1
  fi

  python3 -m venv "$env"
  source "./$env/bin/activate"
  pip install -U pip
}

function ossl() {
  echo | openssl s_client -connect ${1}:443
}

