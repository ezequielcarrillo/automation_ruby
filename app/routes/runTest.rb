post '/runTest' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  location = item['location']

  if location == '/Suites'
  
     tests = getSuiteDependencies(id)
	   suite_execution_id = SecureRandom.hex(20)
	 
     tests.each do |test_id|
        testQueryBuilder(test_id, suite_execution_id)
      end
  else
	  suie_id = nil
    testQueryBuilder(id,suite_execution_id)
  end

end