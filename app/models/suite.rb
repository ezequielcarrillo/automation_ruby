require_relative '../../db/conector'

def updateSuite(id)

  $mysql.query("UPDATE suites SET modified_at ='#{Time.new}', modified_by = '#{getUserName()}' WHERE object_id = '#{id}';")
end

def saveSuiteTests(id, testsIds)

  testsIds.each do |test|

      $mysql.query("INSERT INTO suite_dependencies (suite_id, test_rel_id) VALUES('#{id}','#{test['testId']}');")

  end
  updateSuite(id)
    ''
end

def removeSuiteTests(id, testsId)

  $mysql.query("DELETE FROM suite_dependencies WHERE suite_id ='#{id}' AND  test_rel_id ='#{testsId}';")
  updateSuite(id)
end

def saveSuiteDetails(id, details)

  $mysql.query("UPDATE suites SET object_description = '#{details}' WHERE object_id ='#{id}';")
  updateSuite(id)
end

def getSuiteDependencies(id)

  tests = []
  $mysql.query("SELECT * FROM suite_dependencies WHERE suite_id ='#{id}';").each do |test|
    tests << test['test_rel_id']
  end

  return tests
end

def getSuiteChartData(id) 

	test_ids =[]
	results_history = []
	$mysql.query("SELECT * FROM suite_dependencies
                      INNER JOIN tests ON object_id = test_rel_id
                      WHERE suite_id = '#{id}';",:as => :json).each do |row|
		test_ids << row['test_rel_id']			  
	end
	
	$mysql.query("SELECT suite_execution_id , 
				count(case when result = 1 then 1 end ) as passed, 
				count(case when result = -1 then 1 end) as failed
				FROM automation.test_history
				WHERE test_rel_id = '#{test_ids[0]}' or '#{test_ids[1]}'
				GROUP BY suite_execution_id;").each do |test_result|
				
	  results_history << test_result
	end

  
  results = results_history.to_json
  return results
end