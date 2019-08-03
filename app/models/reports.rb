def getReportDetails

  results = []
  $mysql.query("SELECT tests.object_id , tests.object_name, test_history.test_rel_id, test_history.time_stamp, test_history.test_status, test_history.error_log
                FROM automation.test_history
                inner join tests on test_history.test_rel_id = tests.object_id;;").each do |row|
    results << row
  end


  results = results.to_json
  return results
end