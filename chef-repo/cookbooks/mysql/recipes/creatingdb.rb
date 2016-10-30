#secret = Chef::EncryptedDataBagItem.load_secret("/tmp/encrypted_data_bag_secret")
#sql_password = Chef::EncryptedDataBagItem.load("passwords", "mysql_encrypt", secret)
wpdb=node['t']['database']


bash "wpdb_creation" do
    code <<-EOC
    mysql -u root -ppassword -e "CREATE DATABASE wordpress;"
    mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO *@'localhost';"
    mysql -u root -ppassword -e "FLUSH PRIVILEGES;"
EOC
end
