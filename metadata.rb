name             'osl-nginx'
maintainer       'Oregon State University'
maintainer_email 'systems@osuosl.org'
license          'Apache 2.0'
description      'Installs/Configures osl-nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.4'

depends          'certificate'
depends          'firewall'
depends          'logrotate'
depends          'chef_nginx', '~> 2.9.0'
depends          'osl-munin'
depends          'osl-nrpe'

supports         'centos', '~> 6.0'
supports         'centos', '~> 7.0'
