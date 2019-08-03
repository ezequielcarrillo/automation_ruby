require_relative '../../db/conector'

def updateComponent(id)

  $mysql.query("UPDATE components SET modified_at ='#{Time.new}', modified_by = '#{getUserName()}' WHERE object_id = '#{id}';")
end

def saveComponentDetails(id, details)

  $mysql.query("UPDATE components SET  object_description ='#{details}' WHERE object_id = '#{id}';")

  updateComponent(id)
end

def saveComponentParameter(id, parameters)
 
  parameters.each do |param|

    if param['id'].nil?

      $mysql.query("INSERT INTO component_parameters (component_rel_id, parameter_name, parameter_value, parameter_description) VALUES('#{id}','#{param['name']}','#{param['value']}','#{param['desc']}');")
	  #update test workflow parameters
	 
	 $mysql.query("SELECT * FROM test_workflow WHERE component_rel_id ='#{id}' group by execution_order;").each do |row|
			
			$mysql.query("SELECT id FROM component_parameters WHERE component_rel_id = '#{id}' and parameter_name = '#{param['name']}' and parameter_value = '#{param['value']}' and parameter_description = '#{param['desc']}';").each do |new|

				$mysql.query("INSERT INTO test_workflow (test_rel_id, component_rel_id, execution_order, param_id, param_value) VALUES('#{row['test_rel_id']}','#{id}','#{row['execution_order']}','#{new['id']}','#{param['value']}');")
			end	
       end	
	else
      $mysql.query("UPDATE component_parameters SET parameter_name ='#{param['name']}', parameter_value = '#{param['value']}', parameter_description ='#{param['desc']}' WHERE id ='#{param['id']}';")
    end
  end

  updateComponent(id)
   puts ''
end

def saveComponentAutomation(id,automation)

  automation.each do |auto|

    if auto['id'].nil? or auto['id'] == ''
       #insert
      $mysql.query("INSERT INTO component_automation (component_rel_id, element_rel_id, operation_rel_id, parameter_rel_id, execution_order, assert) VALUES('#{id}','#{auto['element']}','#{auto['operation']}','#{auto['param']}','#{auto['order']}','#{auto['assert']}');")

    else
       #update
      $mysql.query("UPDATE component_automation SET component_rel_id = '#{id}',element_rel_id = '#{auto['element']}',operation_rel_id = '#{auto['operation']}',parameter_rel_id = '#{auto['param']}',execution_order = '#{auto['order']}', assert = '#{auto['assert']}' WHERE id = '#{auto['id']}';")

    end
  end
  updateComponent(id)
    ''
end

def saveComponentScript(id,script)

  $mysql.query("UPDATE components SET object_script = '#{script}' WHERE object_id = '#{id}';")
  updateComponent(id)
end

def deleteComponentParameter(id,parameterId)

  $mysql.query("DELETE FROM component_parameters WHERE id  = '#{parameterId}';")
  #update test workflow parameters
  $mysql.query("DELETE FROM test_workflow WHERE component_rel_id = '#{id}' and param_id = '#{parameterId}';")
  
  updateComponent(id)
end

def deleteComponentAutomation(id,parameterId)

  $mysql.query("DELETE FROM component_automation WHERE id  = '#{parameterId}';")
  updateComponent(id)
end

def deleteScreenshot(id)

  $mysql.query("UPDATE components SET object_screenshot_name = '' WHERE object_id = '#{id}';")
  updateComponent(id)
end


def getWebElementData(id)
  results =[]
  $mysql.query("SELECT * FROM object_properties WHERE object_rel_id = '#{id}';",:as => :json).each do |row|

    results << row
  end
  results = results.to_json
  return results
end


def shareWebElement(id, shareWith)
 puts id
 puts '============' 
  $mysql.query("SELECT * FROM objects
                inner join object_properties on objects.object_id = object_properties.object_rel_id
                WHERE objects.object_id = '#{id}';",:as => :json).each do |row|
puts id
      shareWith.each do |pageObject|
        $mysql.query("INSERT INTO objects (object_name, object_type, created_at, created_by, parent_object_id, copy_of) VALUES('#{row['object_name']}','1','#{row['created_at']}','Copy','#{pageObject}','#{id}');")
         $mysql.query("SELECT MAX(object_id +1) as val FROM objects;",:as => :json).each do |b|
puts '============'           
c = b['val'] 
puts '============'
        $mysql.query("INSERT INTO object_properties (object_rel_id, locator, locator_value, copy_of) VALUES('#{c}','#{row['locator']}','#{row['locator_value']}','#{id}');")
         end
      end
      ''
  end
  ''
end  