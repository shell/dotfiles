# Create directory and cd to it.
#
function mkcd {
  mkdir -p "$1" && cd "$1"
}

function todo() { if [ $# == "0" ]; then cat $TODO; else echo "• $@" >> $TODO; fi }

function todone() { sed -i -e "/$*/d" $TODO; }

function tip() { if [ $# == "0" ]; then cat $TIP; else echo "• $@" >> $TIP; fi }

# function pgrep() { ps aux | grep $1 | grep -v grep }

# function pkill() {
#     local pid
#     pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
#     kill -9 $pid
#     echo -n "Killed $1 (process $pid)"
# }

# function ggrep() { gem list  | grep $1 | grep -v grep }

# function gkill() {
# 		#     local _gem
# 		#     _gem=$(gem list --local | grep $1 | grep -v grep | awk '{ print $1 }')
# 		# gem uninistall _gem
# 		#     echo -n "Uninstalled _gem gem"
# }