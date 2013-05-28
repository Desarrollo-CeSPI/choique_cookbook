
default[:choique][:instance_name] = "ChoiqueCMS by CHEF"
default[:choique][:frontend_url] = nil
default[:choique][:backend_url] = nil
default[:choique][:www][:server_name] = nil #Asume hostname
default[:choique][:www][:server_alias] = nil 
default[:choique][:www][:mail] = "example@choique.edu"

default[:choique][:database][:name] = "choique"
default[:choique][:database][:user] = "choique"
default[:choique][:database][:password] = "choique_pass"
default[:choique][:path] = "/opt/choique"
default[:choique][:git_repository] = "https://github.com/Desarrollo-CeSPI/choique.git"
default[:choique][:git_revision] = "master"
