include_recipe "osl-nginx"

nginx_app "test-cookbook.osuosl.org" do
  directory "/var/www/test-cookbook.osuosl.org"
  include_config true
end

nginx_app "test-cookbook-name.osuosl.org" do
  directory "/var/www/test-cookbook-name.osuosl.org"
  include_config true
  include_name "test-cookbook"
end

nginx_app "test-cookbook-include.osuosl.org" do
  directory "/var/www/test-cookbook-include.osuosl.org"
  include_config true
  include_name "test"
  cookbook_include "osl-nginx"
end

nginx_app "test-cookbook-template.osuosl.org" do
  directory "/var/www/test-cookbook-template.osuosl.org"
  template "test.erb.conf"
  cookbook "osl-nginx-test"
end
