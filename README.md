# Ryzom docker shard

## initial setup
- clone this repo
- copy content of `template` to `shard-data`
- run `docker-compose build` to build containers

- initial database has two users
	- `admin`/`admin` - for nel `/admin` interface and `/ams`
	- `testuser`/`testuser` - for ingame and `/ams`
	- shard address is `shard01.ryzomcore.local`
	- db address is `db.ryzomcore.local`

All `docker-compose` commands must be run inside directory where `docker-compose.yml` is located.

## container ip:port
- `web` makes `127.0.0.1:8081/tcp` (http) available for nel admin, ams, ingame login, patching
- `web` makes `127.0.0.1:8481/tcp` (https) available using certificate from `shard-data/nginx/certs` (generates self-signed certificate if needed)
- `shard01` makes `127.0.0.147851/udp` available for client login.
- `db` has no outside ports
- `php` has no outside ports

`/etc/hosts` on host computer should have mappings for `shard01.ryzomcore.local` for client login.
```
127.0.0.1 shard01.ryzomcore.local
```

## client
`client.cfg` should have
```
StartupHost = "shard01.ryzomcore.local:8081";
Application = { "ryzom_docky", "./client_ryzom_r.exe", "./" };
```

# running

Make sure `template` has been copied to `shard-data` or docker creates directories owned as 'root'.
All containers are running under UID=1000/ryzom, GID=1000/ryzom.

Initial run of `shard01` will clone and compile ryzomcore server. After that shard will start.

- `docker-compose up`
  shard01 will clone and compile server on first run.
  This will take some time and docker-compose logs might not show anything at first.

Compiling will be done using `WITH_SYMBOLS=ON` for better stacktrace messages.

Editing `docker-compose.yml` and setting `shard01` command to `monitor`
will skip clone/compile/start, and just monitors log file.

	When shard01 will start in `batchstart` or `monitor` mode, it will remove old log files.

# shard service console
Enter shard shell (`docker-compose exec shard01 bash`) run `shard` command (or `shard join`).
- `shard stop` will stop all services
- `shard start` will start them again (you may want to press enter on `aes` screen to get that one started).

Services are run in `screen` session,
- `ctrl+a 0` (two keypresses, `ctrl+a`, release, `0`) will select `aes`, `ctrl+a 2` `egs` etc.
- `ctrl+a n` next service
- `ctrl+a p` previous service
- `ctrl+a "` will bring up list for easy selection.
- `ctrl+a d` will exit screen (shard keeps running).

## shard shell access
If `shard01` is running,
- `docker-compose exec shard01 /bin/bash`

If `shard01` is not running,
- `docker-compose run --rm shard01 /bin/bash`


## manual clone/compile

Clone ryzomcore sources into `shard-data/src/ryzom-core.hg` (in host) or `/srv/ryzom/src/ryzom-core.hg` (in shard01) directory.

ie, in `shard01`  shell (clone and compile),
```
mkdir -p $RYZOM_ROOT/src/ryzom-core.hg
hg clone https://bitbucket.org/ryzom/ryzomcore $RYZOM_ROOT/src/ryzom-core.hg/
hg update patches-from-atys
/srv/ryzom/build.sh --core
```

## building

Server needs to be compiled inside `shard01` using `/srv/ryzom/build.sh --core` command.

Parallel jobs can be set using JOBS env variable (JOBS=-j4 is default and set from `docker-compose.yml`)
```
JOBS=-j2 /srv/ryzom/build.sh --core
```

TODO: Client should be compiled on host using `shard-data/build.sh` script.

## restarting shard

Enter `shard01` (`docker-compose exec shard01 /bin/bash`), run `shard stop`, `shard start` in `shard01`.

## restarting service

Enter `shard01` (`docker-compose exec shard01 /bin/bash`), open screen session `shard join`, type 'quit' in service console to restart single server.

# debug
If service is craching, then `shard-data/shards/shard01/nel_*.log` shows it.
There is gdb backtrace under `shard-data/shards/shard01/*/gdb_dump.txt` (new crashes will be added to this).

# backup
All files are in `./shard-data`.

# Securing webserver
If `web` is made to open port in public interface, then following directories should probably not be accessible from the internet
public/ams/template
public/ams/template_c
public/login/logs
public/admin/templates

Nel `/admin` interface should also be restricted to trusted sources only.
public/admin

## shard data
- primitive status is unknown

