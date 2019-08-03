get ('/Tests'){erb :tests}

get '/getParametersInputs' do

  id = params[:componentID]

  getParametersInputs(id)

end

post '/saveTestWorkflow' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  newComponent = item['newComponents']
  updateComponent = item['updateComponents']

  saveTestWorkflow(id, newComponent)
  updateTestWorkflow(id,updateComponent)

end

post '/deleteTestWorkflow' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  component = item['component']
  order = item['order']
  key = item['key']

  deleteTestWorkflow(id,component,key, order)

end

post '/saveTestDetails' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  details = item['comments']

  saveTestDetails(id,details)

end

post '/saveTestBrowser' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  browser = item['browser']

  saveTestBrowser(id,browser)

end

get '/getkeywordData' do

 id = params['id']
 
 getkeywordData(id)

end  

get '/getTestChartData' do

  id = params['id']

  getTestChartData(id) 
  
end

