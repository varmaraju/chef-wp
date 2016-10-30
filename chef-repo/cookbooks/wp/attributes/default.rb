secret = Chef::EncryptedDataBagItem.load_secret("/tmp/encrypted_data_bag_secret")
sql_password = Chef::EncryptedDataBagItem.load("passwords", "mysql_encrypt", secret)



default['wp']['db']['name'] = "wordpress"
default['wp']['db']['user'] = "root"
default['wp']['db']['pass'] = "#{sql_password['password']}"
default['wp']['db']['host'] = 'localhost'
default['wp']['config_perms'] = 0755
