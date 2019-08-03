get ('/keywords'){erb :keywords}



get '/getParametersInputs' do

  id = params[:componentID]

  getParametersInputs(id)

end

post '/savekeywordWorkflow' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  newComponent = item['newComponents']
  updateComponent = item['updateComponents']

  savekeywordWorkflow(id, newComponent)
  updatekeywordWorkflow(id,updateComponent)

end

post '/deletekeywordWorkflow' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  component = item['component']
  order = item['order']

  deletekeywordWorkflow(id,component, order)

end

post '/savekeywordDetails' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  details = item['comments']

  savekeywordDetails(id,details)

end



