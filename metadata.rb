name             'osl-nginx'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
issues_url       'https://github.com/osuosl-cookbooks/osl-nginx/issues'
source_url       'https://github.com/osuosl-cookbooks/osl-nginx'
license          'Apache-2.0'
chef_version     '>= 16.0'
description      'Installs/Configures osl-nginx'
version          '6.0.0'

depends          'certificate'
depends          'logrotate'
depends          'nginx', '~> 11.4.0'
depends          'osl-firewall'
depends          'osl-nrpe'

supports         'centos', '~> 7.0'
supports         'centos', '~> 8.0'
