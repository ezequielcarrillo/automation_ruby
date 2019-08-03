require_relative '../db/conector'

def execute_test(test, test_id, libs,suite_execution_id)
puts 'runner'
	begin
   rescue => e
		 puts e
		 $mysql.query("INSERT INTO test_history (test_rel_id, time_stamp, error_log, suite_execution_id, result) VALUES('#{test_id}','#{Time.new}','#{e}','#{suite_execution_id}','#{-1}');")
	else
		 $mysql.query("INSERT INTO test_history (test_rel_id, time_stamp, error_log, suite_execution_id, result) VALUES('#{test_id}','#{Time.new}','#{'passed'}','#{suite_execution_id}','#{1}');")
		
	end	
end