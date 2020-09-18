describe file('/etc/munin/plugin-conf.d/nginx') do
  its('content') { should match %r{env.url http://localhost:8090/nginx_status} }
end

%w(request status memory).each do |c|
  describe file("/etc/munin/plugins/nginx_#{c}") do
    it { should be_linked_to "/usr/share/munin/plugins/nginx_#{c}" }
  end
end
