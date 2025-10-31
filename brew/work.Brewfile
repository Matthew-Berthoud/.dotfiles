# Add Taps
[
  "sdkman/tap",
].each { |t| tap t }

# Common formulae
[
  "awscli",
  "gemini-cli",
  "go-task",
  "poetry",     # python package management
].each { |pkg| brew pkg }

# macOS-only casks
if OS.mac?
  [
    "lm-studio",
    "ollama-app",
    "postman",
    "slack",
  ].each { |c| cask c }
end

