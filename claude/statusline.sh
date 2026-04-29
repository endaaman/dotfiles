#!/usr/bin/env bash
set -euo pipefail

DATA=$(cat)

# jq check
if ! command -v jq &>/dev/null; then
  echo "jq required"
  exit 0
fi

# Extract all values
model=$(echo "$DATA" | jq -r '.model.display_name // "unknown"')
ctx_total=$(echo "$DATA" | jq -r '.context_window.context_window_size // 0')
ctx_used=$(echo "$DATA" | jq -r '.context_window.used_percentage // 0')
input_tok=$(echo "$DATA" | jq -r '.context_window.total_input_tokens // 0')
output_tok=$(echo "$DATA" | jq -r '.context_window.total_output_tokens // 0')
rl_5h=$(echo "$DATA" | jq -r '.rate_limits.five_hour.used_percentage // empty' 2>/dev/null || true)
rl_5h_reset=$(echo "$DATA" | jq -r '.rate_limits.five_hour.resets_at // empty' 2>/dev/null || true)
rl_7d=$(echo "$DATA" | jq -r '.rate_limits.seven_day.used_percentage // empty' 2>/dev/null || true)
cwd=$(echo "$DATA" | jq -r '.cwd // .workspace.current_dir // ""')

# ~ abbreviation
short_cwd="$cwd"
[[ -n "${HOME:-}" && "$cwd" == "$HOME"* ]] && short_cwd="~${cwd#"$HOME"}"

# Nerd Font pie icon
pie() {
  local p=${1%.*}; p=${p:-0}
  local icons=(󰝦 󰪞 󰪟 󰪠 󰪡 󰪢 󰪣 󰪤 󰪥)
  local i=$(( p * 8 / 100 ))
  (( i > 8 )) && i=8
  echo "${icons[$i]}"
}

# Color by threshold
c() {
  local p=${1%.*}; p=${p:-0}
  if   (( p < 50 )); then printf "\033[32m"
  elif (( p < 75 )); then printf "\033[33m"
  else printf "\033[31m"; fi
}

R="\033[0m"; D="\033[2m"

# Format tokens
f() {
  local n=$1
  if   (( n >= 1000000 )); then awk "BEGIN{printf \"%.1fM\",$n/1000000}"
  elif (( n >= 1000 ));    then awk "BEGIN{printf \"%.1fk\",$n/1000}"
  else echo "$n"; fi
}

# Visible length
vl() { printf '%b' "$1" | sed 's/\x1b\[[0-9;]*m//g' | wc -m; }

# Format context size
ctx_size=""
if (( ctx_total >= 1000 )); then
  ctx_size="$(( ctx_total / 1000 ))k"
fi

# Build left
L=""
L+="󰚩 \033[1;35m${model}${R}"
[[ -n "$ctx_size" ]] && L+="${R} (${ctx_size})"
p=${ctx_used%.*}; p=${p:-0}
L+="  $(c "$p")$(pie "$p") ${p}%${R}  ${D}${R} $(f "$input_tok") ${D}${R} $(f "$output_tok")"
[[ -n "$rl_5h" ]] && {
  q=${rl_5h%.*}; q=${q:-0}
  L+="  ${D}5h${R}$(c "$q") ${q}%${R}"
  [[ -n "$rl_5h_reset" ]] && L+="${D} →$(date -d "@$rl_5h_reset" '+%H:%M')${R}"
}
[[ -n "$rl_7d" ]] && { q=${rl_7d%.*}; q=${q:-0}; L+="  ${D}7d${R}$(c "$q") ${q}%${R}"; }

# Build right
Ri="\033[36m  ${short_cwd}${R}"

# Right-align
w=$(tput cols 2>/dev/null || echo 120)
pad=$(( w - $(vl "$L") - $(vl "$Ri") ))
(( pad < 2 )) && pad=2

echo -e "${L}$(printf '%*s' "$pad" '')${Ri}"
