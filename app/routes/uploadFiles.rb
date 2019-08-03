get ('/uploadLibraries'){ redirect '/Libraries' }

get ('/uploadScreenshot') { redirect '/pageObject' }

post '/uploadLibraries' do

  tempfile = params['library'][:tempfile]
  filename = params['library'][:filename]

  uploadLibrary(tempfile, filename)

  redirect '/Libraries'
end

post '/uploadScreenshot' do

  tempfile = params['screenshot'][:tempfile]
  filename = params['screenshot'][:filename]
  component_id = params[:component_id]

  uploadScreenshot(tempfile, filename, component_id)

  redirect '/pageObject'
end


get '/pic/:id' do

  id = params[:id]
  name = getAttachedFileName(id)

  send_file($pathfolder+"#{name}", :type => 'image/jpeg')

end