default['osl-nginx']['recipes'] = ['default']
default['osl-nginx']['hostname'] = node['fqdn']
default['osl-nginx']['server_port'] = 80
default['osl-nginx']['directory_index'] = [
  'index.html',
  'index.htm',
  'index.php',
]
default['osl-nginx']['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'
default['osl-nginx']['ssl_ciphers'] = %w(
  ECDHE-ECDSA-CHACHA20-POLY1305
  ECDHE-RSA-CHACHA20-POLY1305
  ECDHE-ECDSA-AES128-GCM-SHA256
  ECDHE-RSA-AES128-GCM-SHA256
  ECDHE-ECDSA-AES256-GCM-SHA384
  ECDHE-RSA-AES256-GCM-SHA384
  DHE-RSA-AES128-GCM-SHA256
  DHE-RSA-AES256-GCM-SHA384
  ECDHE-ECDSA-AES128-SHA256
  ECDHE-RSA-AES128-SHA256
  ECDHE-ECDSA-AES128-SHA
  ECDHE-RSA-AES256-SHA384
  ECDHE-RSA-AES128-SHA
  ECDHE-ECDSA-AES256-SHA384
  ECDHE-ECDSA-AES256-SHA
  ECDHE-RSA-AES256-SHA
  DHE-RSA-AES128-SHA256
  DHE-RSA-AES128-SHA
  DHE-RSA-AES256-SHA256
  DHE-RSA-AES256-SHA
  ECDHE-ECDSA-DES-CBC3-SHA
  ECDHE-RSA-DES-CBC3-SHA
  EDH-RSA-DES-CBC3-SHA
  AES128-GCM-SHA256
  AES256-GCM-SHA384
  AES128-SHA256
  AES256-SHA256
  AES128-SHA
  AES256-SHA
  DES-CBC3-SHA
  !DSS
)

default['nginx']['repo_source'] = 'nginx'
default['nginx']['server_names_hash_bucket_size'] = 128
