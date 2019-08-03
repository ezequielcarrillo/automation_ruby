get '/logout' do

  redirect ('/login')
end

post '/logout' do

  session_logout()
end

