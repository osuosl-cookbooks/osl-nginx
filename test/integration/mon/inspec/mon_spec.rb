describe command '/usr/lib64/nagios/plugins/check_nrpe -H 127.0.0.1 -c check_http' do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /HTTP OK/ }
end
