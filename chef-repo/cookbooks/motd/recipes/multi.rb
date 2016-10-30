#
# Cookbook Name:: motd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/etc/multitest" do
   source "multitesting.conf"
end

