set :environment, :production
set :lock => true

configure :production do
  set :bind, '127.0.0.1'
  set :port, 4568
  set :server, %w[thin mongrel webrick]
  set :dump_errors, true
end