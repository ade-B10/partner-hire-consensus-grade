#!/usr/bin/env bash
#
# Re-encrypt the source HTML and produce a fresh index.html for GitHub Pages.
#
# Usage:
#   1. Put the updated unencrypted file at source/Partner_Hire_Consensus_Grade.html
#      (or change SOURCE_FILE below to point wherever you keep it).
#   2. Run: ./update.sh
#   3. Commit + push: git add index.html && git commit -m "Refresh" && git push
#
# Requirements:
#   - Node.js installed
#   - First run will npx-install staticrypt (~10 sec, one-time)
#

set -euo pipefail

# ---- Config ----
PASSWORD='Base10Automation!'
SOURCE_FILE="source/Partner_Hire_Consensus_Grade.html"
OUTPUT_FILE="index.html"
LABEL="Base10 · Partner Hire Consensus Grade"
INSTRUCTIONS="Enter the password to access Base10 · Partner Hire Consensus Grade."
REMEMBER_DAYS=14

# ---- Sanity checks ----
if [ ! -f "$SOURCE_FILE" ]; then
  echo "ERROR: $SOURCE_FILE not found."
  echo ""
  echo "Drop the unencrypted source HTML there first. For example:"
  echo "  mkdir -p source"
  echo "  cp /Users/ade/Desktop/Urizen/Partner_Hire_Consensus_Grade.html source/"
  echo ""
  exit 1
fi

if ! command -v node &> /dev/null; then
  echo "ERROR: Node.js not installed. Install from https://nodejs.org/"
  exit 1
fi

# ---- Encrypt ----
echo "Encrypting $SOURCE_FILE -> $OUTPUT_FILE ..."

# Read the salt from the committed config (keeps password hash stable across updates).
# Pass salt explicitly + disable config discovery: works around a flaky JSON-parse
# bug we hit in some environments when staticrypt auto-loads .staticrypt.json.
SALT=$(python3 -c "import json; print(json.load(open('.staticrypt.json'))['salt'])" 2>/dev/null || echo "")

# Use npx so we don't require a global install
npx -y -p staticrypt staticrypt \
  "$SOURCE_FILE" \
  -p "$PASSWORD" \
  --short \
  --remember "$REMEMBER_DAYS" \
  --label "$LABEL" \
  --instructions "$INSTRUCTIONS" \
  ${SALT:+-s "$SALT" -c false} \
  -d ./_tmp_encrypted

# Move the encrypted output to index.html and customize the title
SOURCE_BASENAME=$(basename "$SOURCE_FILE")
mv "./_tmp_encrypted/$SOURCE_BASENAME" "$OUTPUT_FILE"
sed -i.bak "s|<title>Protected Page</title>|<title>Base10 · Partner Hire Consensus Grade</title>|" "$OUTPUT_FILE"
rm -f "${OUTPUT_FILE}.bak"
rm -rf ./_tmp_encrypted

echo ""
echo "Done. $OUTPUT_FILE updated."
echo ""
echo "Next steps:"
echo "  git add index.html"
echo "  git commit -m \"Refresh Base10 · Partner Hire Consensus Grade ($(date +%Y-%m-%d))\""
echo "  git push"
echo ""
