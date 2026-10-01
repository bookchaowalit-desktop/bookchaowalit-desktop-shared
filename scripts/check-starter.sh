#!/usr/bin/env bash
# Starter contract check. Runs locally and in CI with only bash + git.
# Usage: scripts/check-starter.sh
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

fail=0
err() { echo "FAIL: $*" >&2; fail=1; }

# 1. Required baseline files exist and are non-empty.
for f in README.md LICENSE .gitignore .editorconfig docs/UPGRADE-PLAN.md .github/workflows/ci.yml; do
  [[ -s "$f" ]] || err "missing or empty: $f"
done

# 2. License is MIT (as the README states).
head -n 1 LICENSE | grep -qx 'MIT License' || err "LICENSE is not MIT"

# 3. README keeps the sections the owner model relies on.
for heading in '## Purpose' '## Repository boundary' '## CI' '## Local development' '## License'; do
  grep -qx "$heading" README.md || err "README.md missing section: $heading"
done

# 4. Relative Markdown links point at files that exist.
while IFS= read -r md; do
  dir=$(dirname "$md")
  while IFS= read -r target; do
    target=${target%%#*}
    [[ -z "$target" || "$target" =~ ^[a-z]+: ]] && continue
    [[ -e "$dir/$target" ]] || err "$md links to missing $target"
  done < <(grep -oE '\]\([^)]+\)' "$md" | sed -E 's/^\]\((.*)\)$/\1/')
done < <(git ls-files '*.md')

# 5. No secret-bearing files are tracked.
if git ls-files | grep -Ei '(^|/)(\.env(\..*)?|.*\.pem|.*\.p12|id_rsa|credentials\.json)$' | grep -v '\.example$'; then
  err "secret-like files are tracked (listed above)"
fi

# 6. Status is honest: a starter must not ship product code yet.
status=$(grep -E '^\- \*\*Status:\*\*' README.md | sed -E 's/.*\*\* //')
if [[ "$status" == starter* ]]; then
  if git ls-files | grep -Ev '^(README\.md|LICENSE|\.gitignore|\.editorconfig|docs/|scripts/check-starter\.sh|\.github/)' ; then
    err "README says '$status' but the files above look like implementation; update the Status line"
  fi
fi

if [[ $fail -ne 0 ]]; then
  exit 1
fi
echo "starter contract OK"
