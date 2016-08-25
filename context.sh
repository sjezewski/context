# Include this in your profile a la:
# source path/to/this/directory/context.sh

CTX_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ctx() {
	$CTX_SOURCE_DIR/context.rb $@
}

function pc() {
	ADDRESS=`$CTX_SOURCE_DIR/context.rb use pachctl address 2>/dev/null`
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
	check_kc
	ctx use
	kubectl $@
}


function gc() {
	ctx use
	gcloud $@
}
