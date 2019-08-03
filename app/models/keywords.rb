require_relative '../../db/conector'

def updatekeyword(id)

  $mysql.query("UPDATE keywords SET modified_at ='#{Time.new}', modified_by = '#{getUserName()}' WHERE object_id = '#{id}';")
end

def getParametersInputs(id)

  results =[]

  $mysql.query("SELECT id, parameter_name, parameter_value FROM automation.component_parameters
                WHERE component_rel_id ='#{id}';",:as => :json).each do |row|

    results << row
  end

  results = results.to_json
  return results

end

def updatekeywordWorkflow(id,updateComponent)

  updateComponent.each do |component|

    component['parameters'].each do |row|

       $mysql.query("UPDATE keywords_workflow SET param_value ='#{row['param_value']}',
                     execution_order = '#{component['execution_order']}'
                     WHERE id = '#{row['id']}';")

    end
    if component['parameters'].empty?
      $mysql.query("INSERT INTO keywords_workflow (test_rel_id, component_rel_id, execution_order)
                   VALUES('#{id}', '#{component['object_id']}', '#{component['execution_order']}');")

    end
  end

  updatekeyword(id)
  puts ''
end


def savekeywordWorkflow(id, newComponent)

  newComponent.each do |component|

    component['parameters'].each do |row|

      $mysql.query("INSERT INTO keywords_workflow (test_rel_id, component_rel_id, execution_order, param_id, param_value)
                   VALUES('#{id}', '#{component['object_id']}', '#{component['execution_order']}', '#{row['param_id']}', '#{row['param_value']}');")

      ##save into tests workflow if its used
      $mysql.query("SELECT * FROM test_workflow WHERE keyword_rel_id = '#{id}' group by execution_order;",:as => :json).each do |function|
          $mysql.query("INSERT INTO test_workflow (test_rel_id, component_rel_id, execution_order, param_id, param_value, keyword, keyword_rel_id)
                        VALUES('#{function['test_rel_id']}', '#{component['object_id']}', '#{function['execution_order']}', '#{row['param_id']}', '#{row['param_value']}','2','#{id}');")
       
      end 
    end

    if component['parameters'].empty?
      $mysql.query("INSERT INTO keywords_workflow (test_rel_id, component_rel_id, execution_order)
                   VALUES('#{id}', '#{component['object_id']}', '#{component['execution_order']}');")

    end

  end

  updatekeyword(id)
   puts ''
end

def deletekeywordWorkflow(id,component, order)

  $mysql.query("DELETE FROM keywords_workflow WHERE test_rel_id = '#{id}' and execution_order = '#{order}' and component_rel_id = '#{component}' ")

  ## delete from test worflow
  $mysql.query("DELETE FROM test_workflow WHERE keyword_rel_id = '#{id}' and component_rel_id = '#{component}' ")

  updatekeyword(id)
end


def savekeywordDetails(id,details)

  $mysql.query("UPDATE keywords SET object_description ='#{details}' WHERE object_id = '#{id}';")
  updatekeyword(id)

end

def saveTestBrowser(id,browser)

  $mysql.query("UPDATE keywords SET browser ='#{browser}' WHERE object_id = '#{id}';")
  updatekeyword(id)
end




