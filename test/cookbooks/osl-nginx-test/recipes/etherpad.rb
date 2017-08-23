directory '/etc/nginx/ssl/new/' do
  recursive true
end

link '/etc/nginx/ssl/new/combined_openmrs.org.crt' do
  to '/etc/pki/tls/certs/notes-openmrs.pem'
end

link '/etc/nginx/ssl/new/openmrs.org.key' do
  to '/etc/pki/tls/private/notes-openmrs.key'
end
