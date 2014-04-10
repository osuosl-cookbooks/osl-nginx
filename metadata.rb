name             'osl-nginx'
maintainer       'Oregon State University'
maintainer_email 'systems@osuosl.org'
license          'Apache 2.0'
description      'Installs/Configures osl-nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'
depends          'nginx', "< 2.1.0"
depends          'firewall'
depends          'logrotate'
