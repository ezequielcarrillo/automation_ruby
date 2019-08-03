get '/pageObject' do

  erb :pageObject
end

post '/saveComponentDetails' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  details = item['comments']

  saveComponentDetails(id,details)

end

post '/saveComponentParameter' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  parameters = item['parameters']

  saveComponentParameter(id,parameters)

end

post '/deleteComponentParameter' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  parameterId = item['parameterId']

  deleteComponentParameter(id,parameterId)

end

post '/saveComponentAutomation' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  automation = item['automation']

  saveComponentAutomation(id,automation)

end


post '/deleteComponentAutomation' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  automation = item['parameterId']

  deleteComponentAutomation(id,automation)

end

post '/saveComponentScript' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  script = item['script']

  saveComponentScript(id,script)

end

post '/deleteScreenshot' do

  item = JSON.parse( request.body.read)

  id = item['elementId']
  deleteScreenshot(id)

end

get '/WebElementData' do
 
 id = params[:elementId]
 getWebElementData(id)
end

post '/shareWebElement' do

  item = JSON.parse( request.body.read)

  id = item['elementId']
  shareWith = item['shareWith']

  shareWebElement(id, shareWith)

end
