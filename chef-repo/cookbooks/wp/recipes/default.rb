#
# Cookbook Name:: wp
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

wordpress_latest = Chef::Config[:file_cache_path] + "/wordpress-latest.tar.gz"
remote_file wordpress_latest do
  source "http://wordpress.org/latest.tar.gz"
  mode "0644"
end


execute 'untar the wp' do
  command '/bin/tar -xf /var/chef/cache/wordpress-latest.tar.gz'
  cwd '/var/chef/cache/'
  command '/bin/cp -rf /var/chef/cache/wordpress  /var/www/html/'
  end

template "/var/www/html/wordpress/wp-config.php" do
  source 'wp-config.php.erb'
  mode node['wp']['config_perms']
  variables(
    :db_name           => node['wp']['db']['name'],
    :db_user           => node['wp']['db']['user'],
    :db_password       => node['wp']['db']['pass'],
    :db_host           => node['wp']['db']['host']
   )
end


