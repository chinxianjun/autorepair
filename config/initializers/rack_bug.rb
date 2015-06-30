#require 'rack/bug'
#require 'ipaddr'
#
#ActionController::Dispatcher.middleware.use Rack::Bug,
#    :ip_masks   => [IPAddr.new('192.168.0.200')],
#    :secret_key => 'cYZrww1e1JnRIEUrJDRmhbPumDVhGLcOBciNTfeVwpnWXpqalihvYMo',
#    :password   => 'password'
