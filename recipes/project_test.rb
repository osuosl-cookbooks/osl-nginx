nginx_app "test.example.org" do
    server_aliases ["test.example.com", "test.what.com"]
    directory "/var/www/test.example.org"
    enable_ssl true
    cert_file "/var/www/888"
    cert_key "/var/www/eee"
    enable true
end

nginx_app "what.example.org" do 
    directory "/var/www/test/org"
    enable true 
end

