while true; do
  swaymsg -t get_workspaces | jq -j -c '[.[] | {focused, urgent, num}]'
  echo
  read
done
