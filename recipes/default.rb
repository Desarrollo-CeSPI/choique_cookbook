#
# Cookbook Name:: choique
# Recipe:: default
#
# Copyright (C) 2013 CeSPI - UNLP
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "choique::_dependencies"
include_recipe "choique::_database"
include_recipe "choique::_deploy"
include_recipe "choique::_web_server"

