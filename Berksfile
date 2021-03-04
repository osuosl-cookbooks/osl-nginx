source 'https://supermarket.chef.io'

solver :ruby, :required

cookbook 'firewall', git: 'git@github.com:osuosl-cookbooks/firewall'
cookbook 'osl-firewall', git: 'git@github.com:osuosl-cookbooks/osl-firewall'
cookbook 'osl-nrpe', git: 'git@github.com:osuosl-cookbooks/osl-nrpe'
cookbook 'osl-repos', git: 'git@github.com:osuosl-cookbooks/osl-repos'
cookbook 'osl-selinux', git: 'git@github.com:osuosl-cookbooks/osl-selinux'

# test dependencies
cookbook 'osl-nginx-test', path: 'test/cookbooks/osl-nginx-test'

metadata
