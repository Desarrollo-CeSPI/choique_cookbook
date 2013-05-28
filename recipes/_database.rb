db_connection = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

mysql_database node.choique.database.name do
  connection db_connection
  action :create
end

mysql_database_user node.choique.database.user do
  connection db_connection
  password node.choique.database.password
  action [:create, :grant]
end
