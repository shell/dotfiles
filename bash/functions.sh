# Create directory and cd to it.
#
function mkcd {
  mkdir -p "$1" && cd "$1"
}

function todo() { if [ $# == "0" ]; then cat $TODO; else echo "• $@" >> $TODO; fi }

function todone() { sed -i -e "/$*/d" $TODO; }

function tip() { if [ $# == "0" ]; then cat $TIP; else echo "• $@" >> $TIP; fi }