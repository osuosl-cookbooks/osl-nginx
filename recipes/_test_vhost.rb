# Expands size of server name hash buckets
node.default['nginx']['server_names_hash_bucket_size'] = 128

nginx_app 'test.osuosl.org' do
  server_aliases ['test1.osuosl.org', 'test2.osuosl.org']
  directory '/var/www/test.osuosl.org'
  ssl_enable true
  cert_file '/etc/pki/tls/certs/test.osuosl.org.pem'
  cert_key '/etc/pki/tls/private/test.osuosl.org.key'
  directive_http ['rewrite ^ https://$server_name$request_uri? permanent;']
end

nginx_app 'test-include.osuosl.org' do
  directory '/var/www/test-include.osuosl.org'
  include_config true
end

nginx_app 'test-include-name.osuosl.org' do
  directory '/var/www/test-include-name.osuosl.org'
  include_config true
  include_name 'test'
end
