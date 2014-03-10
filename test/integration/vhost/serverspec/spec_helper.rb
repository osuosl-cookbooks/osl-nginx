# Tests for a nginx install
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

# Setup something with root user paths?
# Not sure what is going on here, but it's in the kitchen-ci docs
RSpec.configure do |c|
    c.before :all do
        c.path = '/sbin:/usr/sbin'
    end
end
