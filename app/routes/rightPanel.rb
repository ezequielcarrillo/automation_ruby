get '/getRightTreeChildElements' do

  location = params[:location]
  selectedFolder =params[:selectedFolder]
  key = params[:key]
  getRightTreeChildElements(location,selectedFolder,key)

end