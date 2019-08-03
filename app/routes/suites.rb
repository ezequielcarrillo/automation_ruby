get ('/Suites'){erb :suites}

post '/saveSuiteTests' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  testsIds = item['tests']

  saveSuiteTests(id, testsIds)

end

post '/saveSuiteDetails' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  details = item['details']

  saveSuiteDetails(id, details)

end

post '/removeSuiteTests' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  testsId = item['tests']

  removeSuiteTests(id, testsId)

end

get '/getSuiteChartData' do

  id = params['id']

  getSuiteChartData(id) 
end