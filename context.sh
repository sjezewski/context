# Include this in your profile a la:
# source path/to/this/directory/context.sh

CTX_SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CTX_SOURCE_DIR/port-authority.sh

function ctx() {
	$CTX_SOURCE_DIR/context.rb $@
}

function pc() {
	check_command pachctl
	ctx use gcloud kubectl pachctl
	PC_ADDRESS=`$CTX_SOURCE_DIR/context.rb view pachctl address`
    PORT=`echo $PC_ADDRESS | cut -f 2 -d ":"`
    if [ -z $PORT ]; then
        PORT=30650
    fi

    if [ "$1" == "port-forward" ]
    then
        KUBECFG=`ctx view kubectl kubeconfig`
        pachctl version
        echo "running: ADDRESS=$PC_ADDRESS pachctl --kubectlflags="--kubeconfig $KUBECFG" -p $PORT $@"
        ADDRESS=$PC_ADDRESS pachctl $@ --kubectlflags="--kubeconfig $KUBECFG" -p $PORT
    else
	    ADDRESS=$PC_ADDRESS pachctl $@
    fi
}

function kc() {
	check_command kubectl
	ctx use kubectl
	kubectl --kubeconfig=`ctx view kubectl kubeconfig` --context=`ctx view kubectl context` $@
}


function gc() {
	check_command gcloud
	ctx use gcloud
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

