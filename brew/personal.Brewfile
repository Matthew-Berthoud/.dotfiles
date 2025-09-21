# Common formulae
[
  "colima",
  "docker",
  "docker-compose",
  "golang",
  "imagemagick",
  "ko",         # SAMBA
  "kubectl",
  "minikube",
  "php",        # GDSC
].each { |pkg| brew pkg }

# macOS-only casks
if OS.mac?
  [
    "burp-suite",                # CTFs
    "eqmac",
    "mactex",
    "microsoft-powerpoint",      # school
    "prismlauncher",             # prism minecraft launcher
    "spotify",
    "zotero",                    # research
    "zulu"                       # java sdk for minecraft
  ].each { |c| cask c }
end
