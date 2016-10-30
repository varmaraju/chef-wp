#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute


package "php" do
     action :install
end

package "php-mysql" do
  action :install
end

cookbook_file "/var/www/html/info.php" do
          source "info.php"
          owner  "root"
          group  "root"
          mode   "0644"
end

service "httpd" do
    action :restart
end

