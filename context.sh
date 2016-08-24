# Include this in your profile a la:
# source path/to/this/directory/context.sh

CTX_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function pc() {
	echo "in wrapper"

	echo "cs: $CTX_SOURCE_DIR"
	ADDRESS=`$CTX_SOURCE_DIR/context.rb use pachctl address 2>/dev/null`
	echo "using address: ($ADDRESS)"
	ADDRESS=$ADDRESS pachctl $@
}

function ctx() {
	$CTX_SOURCE_DIR/context.rb $@
}
