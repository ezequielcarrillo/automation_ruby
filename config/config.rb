set :environment, :development

set :views, ['./app/views/keywords','./app/views/pageObject','./app/views/main','./app/views/reports','./app/views/repository','./app/views/requirements','./app/views/services','./app/views/libraries','./app/views/side_panels','./app/views/suites','./app/views/tests','./app/views/error','./app/views/users','./app/views/help']
set :public_folder, './public'
set :lock => true
enable :logging
enable :sessions

configure :development do

  set :bind, '0.0.0.0'
  set :port, 4567
  set :server, %w[thin mongrel webrick]

end

configure :test do
  set :bind, '0.0.0.0'
  set :port, 4567
  set :server, %w[thin mongrel webrick]

end

configure :production do
  set :bind, '127.0.0.1'
  set :port, 4567
  set :server, %w[thin mongrel webrick]
  set :dump_errors, false
end
