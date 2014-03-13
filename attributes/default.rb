default['osl-nginx']['recipes'] = ["default"]
default['osl-nginx']['hostname'] = node['fqdn']
default['osl-nginx']['hostsites']['enabled'] = []
default['osl-nginx']['hostsites']['disabled'] = []

default['osl-nginx']['hostsites']['log_dir'] = node['nginx']['log_dir']
default['osl-nginx']['hostsites']['default_root'] = "/var/www"

default['nginx']['repo_source'] = "nginx"
