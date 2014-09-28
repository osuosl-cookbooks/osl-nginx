default['osl-nginx']['recipes'] = ["default"]
default['osl-nginx']['hostname'] = node['fqdn']
default['osl-nginx']['server_port'] = 80
default['osl-nginx']['directory_index'] = [ "index.html", "index.htm", "index.php" ]
default['osl-nginx']['hostsites']['vhosts'] = []
default['osl-nginx']['hostsites']['default_root'] = "/var/www"

default['nginx']['repo_source'] = "nginx"
