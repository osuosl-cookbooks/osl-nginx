default['osl-nginx']['recipes'] = ["default"]
default['osl-nginx']['hostname'] = nil || node['fqdn']
default['osl-nginx']['hostsites']['enabled'] = nil
default['osl-nginx']['hostsites']['disabled'] = nil



default['nginx']['repo_source'] = "nginx"