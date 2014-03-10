default['osl-nginx']['recipes'] = ["default"]
default['osl-nginx']['hostname'] = nil || node['fqdn']
default['osl-nginx']['hostsites']['enabled'] = nil
default['osl-nginx']['hostsites']['disabled'] = nil

default['osl-nginx']['hostsites']['log_dir'] = node['nginx']['log_dir']
default['osl-nginx']['hostsites']['default_root'] = node['nginx']['default_root']

default['nginx']['repo_source'] = "nginx"
