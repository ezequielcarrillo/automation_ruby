get('/error'){erb :error}

error 403 do
  #log_error(error)
  redirect '/error'
end

error 500 do
  #log_error(error)
  redirect '/error'
end

error 400 do
  #log_error(error)
  redirect '/error'
end