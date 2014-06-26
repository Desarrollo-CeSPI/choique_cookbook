node.set.apache.listen_ports = [ "80", node.choique.backend_port ]

template "#{node['apache']['dir']}/ports.conf" do
  source "ports.conf.erb"
  cookbook "apache2"
  owner "root"
  group node['apache']['root_group']
  variables :apache_listen_ports => node['apache']['listen_ports'].map { |p| p.to_i }.uniq
  mode 00644
  notifies :restart, "service[apache2]"
end


web_app "choique-frontend" do
  admin_mail node.choique.www.mail
  server_name node.choique.www.server_name
  server_alias node.choique.www.server_alias
  doc_root "#{node.choique.path}/current/web-frontend"
end

web_app "choique-backend" do
  port node.choique.backend_port
  admin_mail node.choique.www.mail
  server_name node.choique.www.server_name
  server_alias node.choique.www.server_alias
  doc_root "#{node.choique.path}/current/web-backend"
end

template "#{node['php']['conf_dir']}/../apache2/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  cookbook 'php'
  variables(:directives => node['php']['directives'])
  notifies :restart, "service[apache2]"
end

