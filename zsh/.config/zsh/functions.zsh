function git-head-branch() {
  command git remote show origin | sed -n '/head branch/s/.*: //p' || return
}

function gfetch() {
  echo "so fetch...ing 'origin' updates..."
  local main=$( git-head-branch )
  git fetch origin
  git merge origin/${main}
}

function breaper() {
  echo "branch reaper is looking local branches that have been merged..."
  git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" { print $1 }' | xargs -r git branch -d
}

function ossl() {
  echo | openssl s_client -connect ${1}:443
}
