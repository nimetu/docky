
USE `nel`;

-- user account and password (testuser)
INSERT INTO `user` VALUES (
	1,                                          -- UId
	'testuser',                                 -- Login
	'Offline',                                  -- State
	':DEV:',                                    -- Privilege
	'',                                         -- ExtendedPrivilege
	0,                                          -- GMId
	ENCRYPT('testuser', '$6$YQFNKpCy6fwvBthq$') -- Password
);

-- new domain
INSERT INTO `domain` VALUES (
	1,                                          -- domain_id
	'ryzom_docky',                              -- domain_name
	'ds_open',                                  -- status (ds_close, *ds_dev, ds_restricted, ds_open)
	1,                                          -- patch_version
	'http://shard01.ryzomcore.local:23001',     -- backup_patch_url (if patch_urls fails)
	'http://shard01.ryzomcore.local:8081/patch',-- patch_urls (space separated)
	'shard01.ryzomcore.local:49998',            -- login_address
	'shard01.ryzomcore.local:49999',            -- session_manager_address
	'ring_shard01',                             -- ring_db_name
	'shard01.ryzomcore.local:30000',            -- web_host
	'web.ryzomcore.local:8081',                 -- web_host_php
	'Docky Shard Domain'                        -- description
);

-- give testuser access to domain
INSERT INTO `permission` VALUES (
	1,                                          -- PermissionId
	1,                                          -- UId
	'ryzom_docky',                              -- ClientApplication
	1,                                          -- DomainId !
	-1,                                         -- ShardId
	'OPEN'                                      -- AccessPrivilege (*OPEN, DEV, RESTRICTED)
);

USE `ring_shard01`;

-- shard will be registered automatically, so this is not strictly needed
INSERT INTO `shard` VALUES (
	1001,                                       -- shard_id
	0,                                          -- WSOnline
	'Shard up',                                 -- MOTD
	'ds_open',                                  -- OldState (ds_close, ds_dev, *ds_restricted, ds_open)
	'ds_open'                                   -- RequiredState (ds_close, *ds_dev, ds_restricted, ds_open)
);

-- 'real' shard info as R2 instance
INSERT INTO `sessions` VALUES (
	1001,                                       -- session_id
	'st_mainland',                              -- session_type (*st_edit, st_anim, st_outland, st_mainland)
	'docky shard mainland',                     -- title
	0,                                          -- owner
	'2005-09-21 12:41:33',                      -- plan_date
	'2005-08-31 00:00:00',                      -- start_date
	'',                                         -- description
	'so_other',                                 -- orientation (so_newbie_training, so_story_telling, so_mistery, so_hack_slash, so_guild_training, *so_other)
	'sl_a',                                     -- level (*sl_a, sl_b, sl_c, sl_d, sl_e, sl_f)
	'rt_strict',                                -- rule_type (*rt_strict, rt_liberal)
	'at_public',                                -- access_type (at_public, *at_private)
	'ss_planned',                               -- state (*ss_planned, ss_open, ss_locked, ss_closed)
	0,                                          -- host_shard_id
	0,                                          -- subscription_slots
	0,                                          -- reserved_slots
	0,                                          -- free_slots
	'et_short',                                 -- estimated_duration (*et_short, et_medium, et_long)
	0,                                          -- final_duration
	0,                                          -- folder_id
	'lang_en',                                  -- lang
	'',                                         -- icone
	'am_dm',                                    -- anim_mode (*am_dm, am_autonomous)
	'rf_fyros,rf_matis,rf_tryker,rf_zorai',     -- race_filter (rf_fyros, ...)
	'rf_kami,rf_karavan,rf_neutral',            -- religion_filter (rf_kami, ...)
	'gf_any_player',                            -- guild_filter (*gf_only_my_guild, gf_any_player)
	'',                                         -- shard_filter (sf_shard00, sf_shard01, ...)
	'lf_a,lf_b,lf_c,lf_d,lf_e,lf_f',            -- level_filter (lf_a, lf_b, ...)
	0,                                          -- subscription_closed
	0                                           -- newcomer
);

