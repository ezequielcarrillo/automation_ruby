['/keywords','/Repository','/pageObject','/Tests','/Suites','/Requirements','/Reports','/Libraries', '/help'].each do |path|

  before ( path ){ authenticated!; @user_name = getUserName() }

end

get '/login' do
 
  @revision = getSvnRevision()
  erb :login , :layout =>false
end

post '/login' do

  login, pass = params[:username] ,params[:pass]

  if authenticate(login, pass)

     redirect ('/Tests')

  else

    @message ='Wrong User Name or Password'

    erb :login , :layout =>false
  end

end