#/bin/sh
# execute_tmux_on_all.sh
for i in ele@141.20.60.112 ele@141.20.60.80 ele@141.20.60.97 ele@141.20.60.110 ele@141.20.60.89 ele@141.20.60.121
do
    tmux splitw "ssh $i"
    tmux select-layout tiled
done
tmux set-window-option synchronize-panes on
