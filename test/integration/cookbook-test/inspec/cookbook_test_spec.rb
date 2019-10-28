# Tests nginx _test_vhost without certificate chain recipe

# Dependencies installed
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should_not be_listening }
end

conf_dir = '/etc/nginx/sites-available'

describe file(::File.join(conf_dir, 'test-cookbook.osuosl.org.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should_not match /ssl_certificate/ }
  its('content') { should match %r{include /etc/nginx/sites-available/test-cookbook\.osuosl\.org_include\.conf;} }
end

describe file(::File.join(conf_dir, 'test-cookbook-name.osuosl.org.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match %r{include /etc/nginx/sites-available/test-cookbook_include\.conf;} }
  its('content') { should match /server_name test-cookbook-name\.osuosl\.org;$/ }
end

describe file(::File.join(conf_dir, 'test-cookbook-include.osuosl.org.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match %r{include /etc/nginx/sites-available/test_include\.conf;} }
  its('content') { should match /server_name test-cookbook-include\.osuosl\.org;$/ }
end

describe file(::File.join(conf_dir, 'test-cookbook-template.osuosl.org.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /cookbook-template$/ }
end

describe file(::File.join(conf_dir, 'test-cookbook-include-template.osuosl.org.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match %r{include /etc/nginx/sites-available/test-include_include\.conf;} }
  its('content') { should match /server_name test-cookbook-include-template\.osuosl\.org;$/ }
end

describe file(::File.join(conf_dir, 'test_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /test-include-name/ }
end

describe file(::File.join(conf_dir, 'test-cookbook_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /test-name-cookbook/ }
end

describe file(::File.join(conf_dir, 'test-cookbook.osuosl.org_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /test-cookbook/ }
end

describe file(::File.join(conf_dir, 'test_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /test-include-name/ }
end

describe file(::File.join(conf_dir, 'test-include_include.conf')) do
  its('mode') { should cmp '0644' }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('content') { should match /cookbook-include-template/ }
end

%w(
  test-cookbook
  test-cookbook-include
  test-cookbook-include
  test-cookbook-template
  test-cookbook-include-template
).each do |f|
  describe file("/etc/nginx/sites-enabled/#{f}.osuosl.org.conf") do
    it { should be_linked_to "/etc/nginx/sites-available/#{f}.osuosl.org.conf" }
  end
end
