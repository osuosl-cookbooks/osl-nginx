# Tests nginx _test_vhost without certificate chain recipe

# Dependencies installed
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

%w(80 443).each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

conf_dir = '/etc/nginx/conf.http.d'
include_dir = '/etc/nginx/includes.d'

describe file(::File.join(conf_dir, 'test.osuosl.org.conf')) do
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') do
    should match %r{^\s*listen 80;[\s\S]*rewrite \^ https://\$server_name\$request_uri\? permanent;[\s\S]*\}$}
  end
  its('content') do
    should_not match %r{^\s*listen 443;[\s\S]*rewrite \^ https://\$server_name\$request_uri\? permanent;[\s\S]*\}$}
  end
  its('content') { should match /server_name test\.osuosl\.org test1\.osuosl\.org test2\.osuosl\.org;/ }
  its('content') { should match /ssl_certificate/ }
  its('content') { should_not match /include/ }
end

describe file(::File.join(conf_dir, 'test-include.osuosl.org.conf')) do
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') do
    should match %r{include /etc/nginx/includes.d/test-include\.osuosl\.org_include\.conf;}
  end
  its('content') { should match /server_name test-include\.osuosl\.org;$/ }
end

describe file(::File.join(conf_dir, 'test-include-name.osuosl.org.conf')) do
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') do
    should match %r{include /etc/nginx/includes.d/test_include\.conf;}
  end
  its('content') { should match /server_name test-include-name\.osuosl\.org;$/ }
end

describe file(::File.join(include_dir, 'test_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /test-include-name/ }
end

describe file(::File.join(include_dir, 'test-include.osuosl.org_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /test-include-hostname/ }
end

describe file '/etc/nginx/conf.http.d/list.conf' do
  %w(
    test
    test-include
    test-include-name
  ).each do |f|
    its('content') { should match %r{^include /etc/nginx/conf.http.d/#{f}.osuosl.org.conf;$} }
  end
end
