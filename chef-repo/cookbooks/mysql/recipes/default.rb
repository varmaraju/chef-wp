#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "mysql-server" do
   action :install
 end

service 'mysqld' do
  action [:start,:enable]
end
secret = Chef::EncryptedDataBagItem.load_secret("/tmp/encrypted_data_bag_secret")
sql_password = Chef::EncryptedDataBagItem.load("passwords", "mysql_encrypt", secret)

bash 'mysql-install' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    expect -c "
    set timeout 10
    spawn mysql_secure_installation
    expect \\"Enter current password for root (enter for none):\\"
    send \\"\r\\"
    expect \\"Change the root password?\\"
    send \\"y\r\\"
    expect \\"New password:\\"
    send \\"#{sql_password['password']}\r\\"
    expect \\"Re-enter new password:\\"
    send \\"#{sql_password['password']}\r\\"
    expect \\"Remove anonymous users?\\"
    send \\"y\r\\"
    expect \\"Disallow root login remotely?\\"
    send \\"y\r\\"
    expect \\"Remove test database and access to it?\\"
    send \\"y\r\\"
    expect \\"Reload privilege tables now?\\"
    send \\"y\r\\"
    expect eof"
  EOH
end

wpdb=node['t']['database']


bash "wpdb_creation" do
    code <<-EOC
    mysql -u root -p#{sql_password['password']} -e "CREATE DATABASE wordpress;"
    mysql -u root -p#{sql_password['password']} -e "GRANT ALL PRIVILEGES ON *.* TO *@'localhost';"
    mysql -u root -p#{sql_password['password']} -e "FLUSH PRIVILEGES;"
EOC
end

