directory node.choique.path do
  owner node.apache.user
  group node.apache.group
  mode "0755"
  action :create
end

%w( shared
    shared/apps/backend/config
    shared/config
    shared/log).each do |dir|
  directory "#{node.choique.path}/#{dir}" do
    owner node.apache.user
    group node.apache.group
    recursive true
    mode "0755"
    action :create
  end
end

node.set.choique.frontend_url = "http://#{node.hostname}" unless node.choique.frontend_url
node.set.choique.backend_url = "http://#{node.hostname}:8000" unless node.choique.backend_url

node.set.choique.backend_port = node.choique.backend_url.match(/:(?<port>\d+)/)[:port] if node.choique.backend_url.match(/:\d+/)

%w( apps/backend/config/factories.yml
    config/app.yml
    config/choique.yml
    config/databases.yml
    config/propel.ini).each do |file|
  template "#{node.choique.path}/shared/#{file}" do
    source "#{file}.erb"
    owner node.apache.user
    group node.apache.group
  end
end


deploy node.choique.path do
  migrate true
  migration_command <<-EOF
    if  `php symfony choique-flavors-list | grep -v '>>' -q`; then
      php symfony choique-flavors-initialize
    fi
    php symfony propel-build-all-load backend
    php symfony choique-fix-perms
    php symfony clear-cache
    php symfony choique-reindex 
  EOF
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
    "log" => "log"
  })
end
