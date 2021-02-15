#!/bin/bash

set -euo pipefail

sigterm(){
	echo "Caught SIGTERM signal!"

	echo "Stopping shard"
	shard down

	echo "Stopping monitor"
	kill -TERM $logger_pid
}

##############################################################################
# do cleanup on container startup
if [ "${1:-}" = "batchstart" ] || [ "${1:-}" = "monitor" ]; then
	trap sigterm SIGTERM

	# common log file for all services
	LOGDIR=/srv/ryzom/shards/$DOMAIN
	LOGFILE=$LOGDIR/log.log

	if [ ! -d $LOGDIR ]; then
		mkdir -p $LOGDIR
	fi

	# cleanup old logs on container startup
	rm -fr $LOGDIR/*.log

	# create empty 'log.log' to monitor
	touch "$LOGFILE"
fi


##############################################################################
# clone / compile if needed
if [ "${1:-}" = "batchstart" ]; then
	if [ ! -d $RYZOM_ROOT/src/ryzom-core.git ]; then
		mkdir -p $RYZOM_ROOT/src/ryzom-core.git
		#git clone --depth 1 --branch ryzomclassic-develop https://github.com/ryzom/ryzomcore.git $RYZOM_ROOT/src/ryzom-core.git/
		git clone --depth 1 --branch hg/hotfix/patches-from-atys https://github.com/ryzom/ryzomcore.git $RYZOM_ROOT/src/ryzom-core.git/
	fi

	#if [ ! -d $RYZOM_ROOT/src/ryzom-server.git ]; then
	#	mkdir -p $RYZOM_ROOT/src/ryzom-server.git
	#	git clone --depth 1 https://gitlab.com/ryzom/ryzom-server.git $RYZOM_ROOT/src/ryzom-server.git/
	#fi

	if [ ! -f $RYZOM_ROOT/server/sbin/ryzom_admin_service ]; then
		echo "Compiling shard..."
		$RYZOM_ROOT/build.sh --core
	fi

	if [ ! -f "$RYZOM_ROOT/server/sbin/ryzom_admin_service" ]; then
		echo "No shard binaries found ($RYZOM_ROOT/server/sbin/ryzom_admin_service)."
		echo "Check README.md for manual cloning/compiling process."
		exit 0
	fi

	echo "Start up shard"
	# instruct AES to launch immediately
	mkdir -p $RYZOM_ROOT/shards/shard01/aes
	echo "LAUNCH" > $RYZOM_ROOT/shards/shard01/aes/aes.launch_ctrl

	shard batchstart
	# switch to monitoring
	set -- monitor
fi

##############################################################################
#
if [ "${1:-}" = "monitor" ]; then
	echo "Starting to monitor $LOGFILE"
	echo "run 'docker-compose exec shard01 /bin/bash' to get access to shell in container"
	# cant use 'exec tail ...' as we are monitoring signal from docker
	tail -F $LOGFILE &
	logger_pid=$!
	wait $logger_pid
	exit
fi

# run custom command
exec "$@"

##############################################################################
# tmux based shard
# TODO: not finished / testing only
echo "Running shard"

SESSION=$DOMAIN
SERVER=/srv/ryzom/server/sbin

# shard working dir (cfg, logs)
SHARD_DIR=/srv/ryzom/shards/$SESSION

cd $SHARD_DIR

#tmux start-server
#tmux has-session -t $SESSION 2> /dev/null && tmux kill-session -t $SESSION

# kill session and shutdown shard
if [ "${1:-}" == "down" ]; then
	echo "Killing tmux '$SESSION'"
	tmux kill-session -t $SESSION
	rm -v $SHARD_DIR/*.state
    rm -v $SHARD_DIR/*launch_ctrl ./global.launch_ctrl
	exit
fi

# attach to existing session
tmux has-session -t $SESSION 2> /dev/null && {
	tmux attach-session -t $SESSION
	exit
}

echo "Starting new '$SESSION'"
tmux -2 new-session -d -s $SESSION
#tmux set default-path "${PWD}

# TODO: first window is 'bash'

OPTS="-A. -C. -L. --nobreak --writepid"
# launch services
tmux new-window -n aes            \; send-keys "$SERVER/ryzom_admin_service                 $OPTS --fulladminname=admin_executor_service --shortadminname=AES" C-m
tmux new-window -n bms_master     \; send-keys "$SERVER/ryzom_backup_service          $OPTS -P49990" C-m
tmux new-window -n egs            \; send-keys "$SERVER/ryzom_entities_game_service   $OPTS" C-m
tmux new-window -n gpms           \; send-keys "$SERVER/ryzom_gpm_service             $OPTS" C-m
tmux new-window -n ios            \; send-keys "$SERVER/ryzom_ios_service             $OPTS" C-m
tmux new-window -n rns            \; send-keys "$SERVER/ryzom_naming_service          $OPTS" C-m
tmux new-window -n rws            \; send-keys "$SERVER/ryzom_welcome_service         $OPTS" C-m
tmux new-window -n ts             \; send-keys "$SERVER/ryzom_tick_service            $OPTS" C-m
tmux new-window -n ms             \; send-keys "$SERVER/ryzom_mirror_service          $OPTS" C-m
#
tmux new-window -n mfs            \; send-keys "$SERVER/ryzom_mail_forum_service      $OPTS" C-m
tmux new-window -n su             \; send-keys "$SERVER/ryzom_shard_unifier_service   $OPTS" C-m
tmux new-window -n fes            \; send-keys "$SERVER/ryzom_frontend_service        $OPTS" C-m
tmux new-window -n sbs            \; send-keys "$SERVER/ryzom_session_browser_service $OPTS" C-m
tmux new-window -n lgs            \; send-keys "$SERVER/ryzom_logger_service          $OPTS " C-m
tmux new-window -n ras            \; send-keys "$SERVER/ryzom_admin_service           $OPTS --fulladminname=admin_service --shortadminname=AS" C-m
# ============ live ais start ===========
tmux new-window -n ais_newbieland \; send-keys "$SERVER/ryzom_ai_service $OPTS -Nais_newbieland -mCommon:Newbieland:Post" C-m
tmux new-window -n ais_fyros      \; send-keys "$SERVER/ryzom_ai_service $OPTS -Nais_fyros      -mCommon:Indoors:Fyros:FyrosNewbie:FyrosIsland:R2Desert:Post" C-m
tmux new-window -n ais_roots      \; send-keys "$SERVER/ryzom_ai_service $OPTS -Nais_roots      -mCommon:Bagne:Nexus:RouteGouffre:Sources:Terre:Kitiniere:R2Roots:Post" C-m
tmux new-window -n ais_zorai      \; send-keys "$SERVER/ryzom_ai_service $OPTS -Nais_zorai      -mCommon:Indoors:Zorai:ZoraiNewbie:ZoraiIsland:R2Jungle:Post" C-m
tmux new-window -n ais_matis      \; send-keys "$SERVER/ryzom_ai_service $OPTS -Nais_matis      -mCommon:Indoors:Matis:MatisNewbie:MatisIsland:R2Forest:Post" C-m
tmux new-window -n ais_tryker     \; send-keys "$SERVER/ryzom_ai_service $OPTS -Nais_tryker     -mCommon:Indoors:Tryker:TrykerNewbie:TrykerIsland:R2Lakes:Post" C-m
# ============ live ais stop ============

#echo "attaching tp '$SESSION'"
#tmux attach-session -t $SESSION

#tmux selectp -t 1
#tmux send-keys "bash" C-m

#tmux selectp -t 2
#tmux send-keys "bash" C-m

# bms_pd_master
#NO: screen -t bms_pd_master $RYZOM_SCRIPTS/service_launcher.sh bms_pd_master ryzom_backup_service -C. -L. --nobreak --writepid -P49992


# mos
#NO:screen -t mos $RYZOM_SCRIPTS/service_launcher.sh mos ryzom_monitor_service -C. -L. --nobreak --writepid

# pdss
#NO:screen -t pdss $RYZOM_SCRIPTS/service_launcher.sh pdss ryzom_pd_support_service -C. -L. --nobreak --writepid

# ais_newbyland - Karu: ryzomcore newbieland
#NO:screen -t ais_newbyland $RYZOM_SCRIPTS/service_launcher.sh ais_newbyland ryzom_ai_service -C. -L. --nobreak --writepid -mCommon:Newbieland:Post

