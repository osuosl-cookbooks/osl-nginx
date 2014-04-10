default['osl-nginx']['recipes'] = ["default"]
default['osl-nginx']['hostname'] = node['fqdn']
default['osl-nginx']['hostsites']['vhosts'] = []

default['osl-nginx']['hostsites']['default_root'] = "/var/www"

default['nginx']['repo_source'] = "nginx"
