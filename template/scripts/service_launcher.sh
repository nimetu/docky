#!/bin/bash

# the object is to make a launcher script that works with a command file to determine when to launch the application that it is responsible for

#DOMAIN=$(pwd |sed "s%/home/nevrax/%%" | sed "s%/.*%%")
#DOMAIN=shard
#NAME_BASE=$(pwd | sed 's/\/home\/nevrax\///' | sed 's/^.*\///')

NAME=$1
NAME_BASE="$NAME/$NAME"

mkdir $NAME
shift

EXECUTABLE=$1
shift

CTRL_CMDLINE=$*

CTRL_FILE=${NAME_BASE}.launch_ctrl
NEXT_CTRL_FILE=${NAME_BASE}.deferred_launch_ctrl

STATE_FILE=${NAME_BASE}.state
START_COUNTER_FILE=${NAME_BASE}.start_count

USE_GDB=1

echo
echo ---------------------------------------------------------------------------------
echo Starting service launcher
echo ---------------------------------------------------------------------------------
printf "%-16s = " CMDLINE         ; echo $CTRL_CMDLINE
printf "%-16s = " CTRL_FILE       ; echo $CTRL_FILE
printf "%-16s = " NEXT_CTRL_FILE  ; echo $NEXT_CTRL_FILE
printf "%-16s = " STATE_FILE      ; echo $STATE_FILE
echo ---------------------------------------------------------------------------------
echo

# reinit the start counter
echo 0 > $START_COUNTER_FILE
START_COUNTER=0

echo Press ENTER to launch program
while true
do

	# see if the conditions are right to launch the app
	if [ -e $CTRL_FILE ]
	then

		# a control file exists so read it's contents
		CTRL_COMMAND=_$(cat $CTRL_FILE)_

		# do we have a 'launch' command?
		if [ $CTRL_COMMAND = _LAUNCH_ ]
		then

			# update the start counter
			START_COUNTER=$(( $START_COUNTER + 1 ))
			echo $START_COUNTER > $START_COUNTER_FILE

			# big nasty hack to deal with the special cases of ryzom_naming_service and ryzom_admin_service who have badly names cfg files
			for f in ryzom_*cfg
			do
				cp $f $(echo $f | sed "s/ryzom_//")
			done

			# we have a launch command so prepare, launch, wait for exit and do the housekeeping
			echo -----------------------------------------------------------------------
			echo Launching ...
			echo
			printf RUNNING > $STATE_FILE

			#$CTRL_CMDLINE
			if [[ "$USE_GDB" == "1" ]]
			then
				if [ "$NAME" = "egs" ] || [ "$NAME" = "ios" ] || [ "$NAME" = "ais_fyros" ] || [ "$NAME" = "ais_matis" ] || [ "$NAME" = "ais_tryker" ] || [ "$NAME" = "ais_roots" ] || [ "$NAME" = "ais_zorai" ] || [ "$NAME" = "ais_ark" ] || [ "$NAME" = "ais_gpms" ]
				then
					gdb -batch -ex "set logging file $NAME/gdb_dump.txt" -ex "set logging on" -ex "run $CTRL_CMDLINE" -ex "bt" $EXECUTABLE
				fi
				$EXECUTABLE $CTRL_CMDLINE
			else
				$EXECUTABLE $CTRL_CMDLINE
			fi

			echo -----------------------------------------------------------------------
			printf STOPPED > $STATE_FILE

			# consume (remove) the control file to allow start once
			rm -f $CTRL_FILE

			echo Press ENTER to relaunch
		fi
	fi

	# either we haven't launched the app yet or we have launched and it has exitted
	if [ -e $NEXT_CTRL_FILE ]
	then
		# we have some kind of relaunch directive lined up so deal with it
		mv $NEXT_CTRL_FILE $CTRL_FILE
	else
		# give the terminal user a chance to press enter to provoke a re-launch when auto-relaunch in AES is disabled
		HOLD=`sh -ic '{ read a; echo "ENTER" 1>&3; kill 0; } | { sleep 2; kill 0; }' 3>&1 2>/dev/null`
		if [ "${HOLD}" = "ENTER" ]
		then
			printf LAUNCH > $CTRL_FILE
		fi
	fi

done

