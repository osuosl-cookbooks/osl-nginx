# Resolves a weird issue in the etherpad suite where the nginx service will be
# successfully started by Chef but only listen on 80 and not 8090/443. If you
# go into the VM and manually try to (re)start the service, it will fail
# because SELinux blocks this port. Fixing this SELinux issue also resolves
# nginx not listening to 443 for some reason.
execute 'semanage port -a -t http_port_t  -p tcp 8090' do
  not_if 'semanage port -l | grep http_port_t | grep 8090'
end

directory '/etc/nginx/ssl/new/' do
  recursive true
end

link '/etc/nginx/ssl/new/combined_openmrs.org.crt' do
  to '/etc/pki/tls/certs/notes-openmrs.pem'
end

link '/etc/nginx/ssl/new/openmrs.org.key' do
  to '/etc/pki/tls/private/notes-openmrs.key'
end
