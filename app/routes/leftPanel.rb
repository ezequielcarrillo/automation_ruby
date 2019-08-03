post '/addNewElement' do

  item = JSON.parse(request.body.read)

  itemName = item['itemName']
  itemType = item['itemType']
  itemClass = item['itemClass']
  itemParentId = item['itemParentId']

  addNewElement(itemName, itemType, itemClass, itemParentId )

end


post '/addNewWebElement' do

  item = JSON.parse(request.body.read)

  itemName = item['itemName']
  itemType = item['itemType']
  itemClass = item['itemClass']
  itemParentId = item['itemParentId']

  addNewWebElement(itemName, itemType, itemClass, itemParentId )

end

get '/leftPanelData' do

 location = params[:location]

 getLeftSidepanelData(location)

end

get '/rightPanelData' do

  location = params[:location]

  getRightSidepanelData(location)

end

get '/getTreeChildElements' do

  location = params[:location]
  selectedFolder =params[:selectedFolder]

  getTreeChildElements(location,selectedFolder)

end

get '/getSelectedElementData' do

  location = params[:location]
  id =params[:id]

  getSelectedElementData(location,id)
end


get '/getPageObjectWebElements' do
  id = params[:id]
  getPageObjectWebElements(id)

end  

post '/editElementName' do

  item = JSON.parse(request.body.read)

  location = item['location']
  elementId = item['elementId']
  elementNewName = item['elementNewName']

  updateElementName(location,elementId,elementNewName)

end

post '/removeSelectedElement' do

  item = JSON.parse(request.body.read)

  location = item['location']
  elementId = item['elementId']

  removeSelectedElement(location,elementId)

end

#TODO
post '/removeSelectedWebElement' do

  item = JSON.parse(request.body.read)

  location = item['location']
  elementId = item['elementId']

  removeSelectedWebElement(elementId)

end

##TODO
post '/editWebElementName' do

  item = JSON.parse(request.body.read)

  location = item['location']
  elementId = item['elementId']
  elementNewName = item['elementNewName']

  updateWebElementName(elementId,elementNewName)

end