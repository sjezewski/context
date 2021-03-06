function pa-start() {
    pc port-forward &
    child=$!
    echo $child > $PWD/.port-authority
}

function pa-stop() {
    kill -9 `cat $PWD/.port-authority`
}

function pa-running() {
    pid=`cat $PWD/.port-authority`
    # return value will indicate if its running
    ps -e | grep kubectl | grep $pid
}

function pa-stop-as-needed() {
    pa-running
    if [ $? -eq 0 ]
    then
        pa-stop
    fi
}

function pa-restart() {
    pa-stop-as-needed
    pa-start
}

function pa-restart-as-needed() {
   pa-running
   if [ $? -ne 0 ]
   then
       pa-start
   fi
}

function pa-all-ports() {
    ps -ef | grep kubectl | grep -v pachctl | grep port-forward | grep pachd | rev | cut -f 1 -d " " | rev | cut -f 1 -d ":" | sort
}

function pa-port-from-pid() {
    ps -ef | grep kubectl | grep -v pachctl | grep port-forward | grep pachd | grep `cat $PWD/.port-authority` | rev | cut -f 1 -d " " | rev | cut -f 1 -d ":"
}

function pa-assasinate() {
    # seeks out a PID w a matching port and kills it
    ps -ef | grep kubectl | grep -v pachctl | grep port-forward | grep pachd | cut -f 2 -d " " | xargs kill $1
}
