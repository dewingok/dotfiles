function activate() {
  local env=${1:-".venv"}

  if [[ ! -d "$env" ]]; then
    echo "Virtual envirnoment '$env' not found."
    return 1
  fi

  source "./$env/bin/activate"
}

function make-venv() {
  local env=${1:-".venv"}
  if [[ -d "$env" ]]; then
    echo "Virtual environment '$env' already exists."
    return 1
  fi

  python3 -m venv "$env"
  source "./$env/bin/activate"
  pip install -U pip
}

# function git-pull-rebase() {
#   local branch=${1:-"main"}
#
#   if git rev-parse --is-inside-work-tree &> /dev/null; then
#     git checkout $branch
#     git fetch origin $branch
#     git reset --hard origin/$branch
#   fi
# }

function git-head-branch() {
  command git remote show origin | sed -n '/HEAD branch/s/.*: //p' || return
}

function gretch() {
  echo "So fetch...ing 'origin' updates..."
  local main=$( git-head-branch )
  git fetch origin
  git merge origin/${main}
}

function sqreap() {
  echo "Squash Reaper is looking local branches that have been merged..."
  git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" { print $1 }' | xargs -r git branch -D
}

function ossl() {
  echo | openssl s_client -connect ${1}:443
}
