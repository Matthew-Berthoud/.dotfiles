#!/usr/bin/python3

"""
Removes all unnecessary whitespace to get best score on CSSBattle.dev
Copy code to clipboard, run the following, then paste the result.

pbpaste | python $SCRIPTS/cssbattle_condenser.py | pbcopy
"""

import re
import sys

# Read all input from stdin
text = "".join(line.strip() for line in sys.stdin)

# Remove HTML comments (anything between <!-- and -->)
text = re.sub(r"<!--.*?-->", "", text, flags=re.DOTALL)

# Remove whitespace that isn't syntactically necessary
newtext = ""
for i, c in enumerate(text):
    if c != " ":
        newtext += c
        continue
    if text[i - 1].isalnum() and i + 1 < len(text) and text[i + 1].isalnum():
        newtext += c

print(newtext)
