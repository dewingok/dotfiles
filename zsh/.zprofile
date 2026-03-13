# Set PATH, MANPATH, etc., for Homebrew.
if command -v /opt/homebrew/bin/brew &> /dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif command -v /usr/local/homebrew/bin/brew &> /dev/null; then
  eval "$(/usr/local/homebrew/bin/brew shellenv)"
elif command -v /home/linuxbrew/.linuxbrew/bin/brew &> /dev/null; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
