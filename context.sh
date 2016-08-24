# Include this in your profile a la:
# source path/to/this/directory/context.sh

CTX_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ctx() {
	$CTX_SOURCE_DIR/context.rb $@
}

function pc() {
	echo "in wrapper"

	echo "cs: $CTX_SOURCE_DIR"
	ADDRESS=`$CTX_SOURCE_DIR/context.rb use pachctl address 2>/dev/null`
	echo "using address: ($ADDRESS)"
	ADDRESS=$ADDRESS pachctl $@
}

function check_kc() {
	which kubectl
	if [ $? -ne 0 ]
	then
		echo "Cannot find kubectl on your \$PATH. Please make sure its installed"
		exit 1
	fi
}

function kc() {
	echo "in wrapper"
	check_kc
	echo "cs: $CTX_SOURCE_DIR"
	ctx use
	ADDRESS=$ADDRESS kubectl $@
}
