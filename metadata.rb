name             'osl-nginx'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
issues_url       'https://github.com/osuosl-cookbooks/osl-nginx/issues'
source_url       'https://github.com/osuosl-cookbooks/osl-nginx'
license          'Apache-2.0'
chef_version     '>= 12.18' if respond_to?(:chef_version)
description      'Installs/Configures osl-nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.2'

depends          'certificate'
depends          'firewall'
depends          'logrotate'
depends          'chef_nginx', '~> 6.2.0'
depends          'osl-munin'
depends          'osl-nrpe'

supports         'centos', '~> 6.0'
supports         'centos', '~> 7.0'
