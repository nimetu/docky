
USE `nel_tool`;

INSERT INTO `neltool_users` VALUES (
	1,                                          -- user_id
	'admin',                                    -- user_name
	'21232f297a57a5a743894a0e4a801fc3',         -- user_password
	1,                                          -- user_group_id
	0,                                          -- user_created
	1,                                          -- user_active
	0,                                          -- user_logged_last
	0,                                          -- user_logged_count
	0                                           -- user_menu_style
);

INSERT INTO `neltool_domains` VALUES (
	1,                                                                        -- domain_id
	'docky',                                                                  -- domain_name
	'shard01.ryzomcore.local',                                                -- domain_as_host
	46700,                                                                    -- domain_as_port
	'/srv/ryzom/shards/shard01/save_shard/rrd_graphs',                        -- domain_rrd_path
	'',                                                                       -- domain_las_admin_path
	'',                                                                       -- domain_las_local_path
	'ryzom_docky',                                                            -- domain_application
	'mysql://root:ryzom-mysql-root-password@db.ryzomcore.local/ring_shard01', -- domain_sql_string
	0,                                                                        -- domain_hd_check
	'/srv/ryzom/shards/shard01/save_shard/www',                               -- domain_mfs_web
	'mysql://root:ryzom-mysql-root-password@db.ryzomcore.local/csr_forums'    -- domain_cs_sql_string
);
INSERT INTO `neltool_shards` VALUES (
	1,           -- shard_id
	'shard01',   -- shard_name
	'shard01',   -- shard_as_id
	1,           -- shard_domain_id
	'en',        -- shard_lang
	0            -- shard_restart
);
-- grant user group access to domain/shard
INSERT INTO `neltool_group_domains` VALUES (1,1,1);
INSERT INTO `neltool_group_shards` VALUES (1,1,1,1);


