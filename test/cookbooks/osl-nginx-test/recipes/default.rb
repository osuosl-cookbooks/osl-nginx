include_recipe 'osl-nginx'

file '/etc/nginx/conf.d/test-kitchen.conf' do
  content 'server_names_hash_bucket_size 128;'
  notifies :reload, 'nginx_service[osuosl]', :immediately
end

# Default app test, but pull the include config
# (files/default/test.osuosl.org/test-cookbook.osuosl.org.conf) from the test
# cookbook.
nginx_app 'test-cookbook.osuosl.org' do
  directory '/var/www/test-cookbook.osuosl.org'
  include_config true
end

# Same as above but lets pull in a file named 'test.conf' from the same folder
# as above in the test cookbook.
nginx_app 'test-cookbook-name.osuosl.org' do
  directory '/var/www/test-cookbook-name.osuosl.org'
  include_config true
  include_name 'test-cookbook'
end

# Pull the include config from the osl-nginx cookbook named 'test.conf'.
nginx_app 'test-cookbook-include.osuosl.org' do
  directory '/var/www/test-cookbook-include.osuosl.org'
  include_config true
  include_name 'test'
  cookbook_include 'osl-nginx'
end

# Use a custom vhost template from the test cookbook. This completely replaces
# the default template we se in osl-nginx.
nginx_app 'test-cookbook-template.osuosl.org' do
  directory '/var/www/test-cookbook-template.osuosl.org'
  template 'test.erb.conf'
  cookbook 'osl-nginx-test'
end

# Include a config using a template from the test cookbook named test-include.
nginx_app 'test-cookbook-include-template.osuosl.org' do
  directory '/var/www/test-cookbook-include-template.osuosl.org'
  include_config true
  include_resource 'template'
  include_name 'test-include'
end
