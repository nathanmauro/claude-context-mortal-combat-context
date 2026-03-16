#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
PCT_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
REMAINING=$((100 - PCT_USED))

# Colors
RED='\033[91m'
YELLOW='\033[93m'
GREEN='\033[92m'
CYAN='\033[96m'
WHITE='\033[97m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

# Health bar color based on remaining context (like health in MK)
if [ "$REMAINING" -le 10 ]; then
  HP_COLOR="$RED"
  LABEL="DANGER"
elif [ "$REMAINING" -le 25 ]; then
  HP_COLOR="$RED"
  LABEL="CRITICAL"
elif [ "$REMAINING" -le 50 ]; then
  HP_COLOR="$YELLOW"
  LABEL="WOUNDED"
else
  HP_COLOR="$GREEN"
  LABEL="FIGHT!"
fi

# Build the health bar — 20 segments
BAR_WIDTH=20
FILLED=$((REMAINING * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))

BAR=""
for ((i=0; i<FILLED; i++)); do BAR+="█"; done
DRAIN=""
for ((i=0; i<EMPTY; i++)); do DRAIN+="░"; done

COST_FMT=$(printf '$%.2f' "$COST")

echo -e "${BOLD}${WHITE}${MODEL}${RESET} ${DIM}//${RESET} ${BOLD}${HP_COLOR}${LABEL}${RESET} ${HP_COLOR}${BAR}${RESET}${DIM}${DRAIN}${RESET} ${BOLD}${HP_COLOR}${REMAINING}%${RESET} ${DIM}HP${RESET} ${DIM}|${RESET} ${DIM}${COST_FMT}${RESET}"
