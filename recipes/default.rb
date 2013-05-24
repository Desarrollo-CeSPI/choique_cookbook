#
# Cookbook Name:: choique
# Recipe:: default
#
# Copyright (C) 2013 CeSPI - UNLP
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "php::default"
include_recipe "apache::default"
include_recipe "apache::mod_php5"
include_recipe "mysql::server"

db_connection = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}
mysql_database node.choique.database.name do
  connection db_connection
  action :create
end

mysql_database_user node.choique.database.user do
  connection db_connection
  password node.choique.database.password
  action :create
end

directory node.choique.path do
  owner node.apache.user
  group node.apache.group
  mode "0755"
  action :create
end

%w(apps/backend/config config log).each do |dir|
  directory "#{node.choique.path}/shared/#{dir}" do
    owner node.apache.user
    group node.apache.group
    mode "0755"
    action :create
  end
end

["apps/backend/config/factories.yml",
"config/app.yml",
"config/choique.yml",
"config/databases.yml",
"config/propel.ini"].each do |d|
  file "#{node.choique.path}/shared/#{d}" do
    content 'pepe'
  end
end

#bash "install_choique" do
#  cwd node.choique.path
#  owner node.apache.user
#  group node.apache.group
#  command <<-EOF
#    php symfony choique-flavors-initialize
#    php symfony propel-build-all-load backend
#    php symfony choique-fix-perms
#    php symfony clear-cache
#    php symfony choique-reindex 
#  EOF
#end

#git node.choiuqe.path do
#  repository node.choique.git_repository
#  reference node.choique.git_revision
#  action :sync
#  notifies :run, "bash[install_choique]"
#end



deploy node.choique.path do
  migrate false
  user node.apache.user
  group node.apache.group
  repository node.choique.git_repository
  revision node.choique.git_revision
  symlink_before_migrate ({
    "apps/backend/config/factories.yml"   => "apps/backend/config/factories.yml",
    "config/app.yml"                      => "config/app.yml",
    "config/choique.yml" => "config/choique.yml",
    "config/databases.yml" =>  "config/databases.yml",
    "config/propel.ini" => "config/propel.ini",
    "logs" => "logs"
  })
end
