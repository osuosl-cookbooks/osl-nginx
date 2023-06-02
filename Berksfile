source 'https://supermarket.chef.io'

solver :ruby, :required

cookbook 'osl-firewall', git: 'git@github.com:osuosl-cookbooks/osl-firewall'
cookbook 'osl-nrpe', git: 'git@github.com:osuosl-cookbooks/osl-nrpe'
cookbook 'osl-repos', git: 'git@github.com:osuosl-cookbooks/osl-repos'
cookbook 'osl-resources', git: 'git@github.com:osuosl-cookbooks/osl-resources', branch: 'main'
cookbook 'osl-selinux', git: 'git@github.com:osuosl-cookbooks/osl-selinux'

# test dependencies
cookbook 'osl-nginx-test', path: 'test/cookbooks/osl-nginx-test'

metadata
