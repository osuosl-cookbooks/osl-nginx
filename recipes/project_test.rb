nginx_app "test.example.org" do
    server_aliases ["test.example.com", "test.what.com"]
    enable true
end

nginx_app "what.example.org" do 
    directory "/var/www/test/org"
    enable true 
end

