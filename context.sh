# Include this in your profile a la:
# source path/to/this/directory/context.sh

CTX_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ctx() {
	$CTX_SOURCE_DIR/context.rb $@
}

function pc() {
	check_command pachctl
	ctx use
	PC_ADDRESS=`$CTX_SOURCE_DIR/context.rb view pachctl address`
	ADDRESS=$PC_ADDRESS pachctl $@
}

function kc() {
	check_command kubectl
	ctx use
	kubectl $@
}


function gc() {
	check_command gcloud
	ctx use
	gcloud $@
}

function check_command() {
	which $1 1>/dev/null
	if [ $? -ne 0 ]
	then
		echo "Cannot find $1 on your \$PATH. Please make sure its installed"
		exit 1
	fi
}

