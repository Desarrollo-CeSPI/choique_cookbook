# Choique cookbook

Instala un Choique CMS completo, considerando DB mysql, apache y el producto en si

## Usando Vagrant para probarlo rápidamente

Para probar el producto en forma rápida, sugerimos:

* Instalar [Vagrant](http://www.vagrantup.com/) siguiendo las instrucciones del
  producto

* Instalar el plugin de Berkshelf 

```
vagrant plugin install vagrant-berkshelf
```

* Clonar este repo

```
git clone https://github.com/Desarrollo-CeSPI/choique_cookbook.git
```

* Iniciar la máquina virtual
```
cd choique_cookbook
vagrant up
```

* Probarlo en un navegador ingresando a:

  * Acceder al frontend: http://33.33.33.10
  * Acceder al backend: http://33.33.33.10:8000 
    * El usuario y contraseña por defecto es: `admin`

>La dirección ip puede cambiarse editando Vagrantfile

Se provee además un ejemplo de Vagrantfile para utilizar choique en Amazon EC2

# Requerimientos

Este cookbook utiliza, y por tanto depende de los siguientes cookbooks:

* apt
* apache2
* php
* mysql
* database

# Uso

Solo tiene una receta: `default` que hace todo

# Attributos

Los atributos a cambiar son:

```ruby
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
```
# Author

Author:: Christian A. Rodriguez(<car@cespi.unlp.edu.ar>)
