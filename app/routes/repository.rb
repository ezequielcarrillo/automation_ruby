get ('/Repository') { erb :repository }


post '/saveObjectProperties' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  locator = item['locator']
  locatorValue = item['locatorValue']

  saveObjectProperties(id, locator, locatorValue)

end

post '/saveObjectDetails' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  details = item['comments']

  saveObjectDetails(id, details)

end