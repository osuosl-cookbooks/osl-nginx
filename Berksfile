source 'https://supermarket.chef.io'

cookbook 'firewall', git: 'git@github.com:osuosl-cookbooks/firewall'
cookbook 'nagios', git: 'git@github.com:osuosl-cookbooks/nagios'
# This is required because of the dependency in the nagios cookbook. This will
# be removed when we switch to the newer upstream nrpe cookbook.
cookbook 'osl-apache', git: 'git@github.com:osuosl-cookbooks/osl-apache'
cookbook 'osl-munin', git: 'git@github.com:osuosl-cookbooks/osl-munin'
cookbook 'osl-nagios', git: 'git@github.com:osuosl-cookbooks/osl-nagios'
cookbook 'osl-nginx-test', path: 'test/cookbooks/osl-nginx-test'

metadata
