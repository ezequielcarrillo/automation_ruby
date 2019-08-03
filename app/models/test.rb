require_relative '../../db/conector'

def updateTest(id)

  $mysql.query("UPDATE tests SET modified_at ='#{Time.new}', modified_by = '#{getUserName()}' WHERE object_id = '#{id}';")
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


def updateTestWorkflow(id,updateComponent)

  updateComponent.each do |component|
  
      if component['browser']=='key'

            component['functions'].each do |function|
                if function['parameters'] == nil
                      $mysql.query("UPDATE test_workflow SET test_rel_id = '#{id}', component_rel_id = '#{component['object_id']}',
                                    execution_order = '#{component['execution_order']}'
                                    WHERE id = '#{component['id']}' and keyword_rel_id = '#{component['object_id']}';")

                else  
                   $mysql.query("UPDATE test_workflow SET test_rel_id = '#{id}', component_rel_id = '#{component['object_id']}',
                                    execution_order = '#{component['execution_order']}'
                                    WHERE id = '#{component['id']}' and keyword_rel_id = '#{component['object_id']}';")

                    function['parameters'].each do |param|
                          $mysql.query("UPDATE test_workflow SET param_value ='#{param['param_value']}',
                                        execution_order = '#{component['execution_order']}'
                                        WHERE id = '#{param['id']}';")
                    end                    
                end                   
            end                 
      else      
          component['parameters'].each do |row|
              $mysql.query("UPDATE test_workflow SET param_value ='#{row['param_value']}',
                            execution_order = '#{component['execution_order']}'
                            WHERE id = '#{row['id']}';")
          end          
      end 
    
  end   

  updateTest(id)
  puts ''
end


def saveTestWorkflow(id, newComponent)

  newComponent.each do |component|

        if component['object_key']=='key'
            $mysql.query("INSERT INTO test_workflow (test_rel_id, keyword_rel_id, execution_order, keyword)
                              VALUES('#{id}', '#{component['object_id']}', '#{component['execution_order']}','1');")
           ##save parameters  
           $mysql.query("SELECT * from keywords_workflow
                        WHERE test_rel_id = '#{component['object_id']}';",:as => :json).each do |function|
                          
                 $mysql.query("INSERT INTO test_workflow (test_rel_id, component_rel_id, execution_order, param_id, param_value, keyword, keyword_rel_id)
                               VALUES('#{id}', '#{function['component_rel_id']}', '#{component['execution_order']}', '#{function['param_id']}', '#{function['param_value']}','2','#{component['object_id']}');")
       
            end                 
        else 

            if component['parameters'].empty?
                $mysql.query("INSERT INTO test_workflow (test_rel_id, component_rel_id, execution_order,keyword)
                            VALUES('#{id}', '#{component['object_id']}', '#{component['execution_order']}', '0');")
            else  
                component['parameters'].each do |row|

                    $mysql.query("INSERT INTO test_workflow (test_rel_id, component_rel_id, execution_order, param_id, param_value, keyword)
                              VALUES('#{id}', '#{component['object_id']}', '#{component['execution_order']}', '#{row['param_id']}', '#{row['param_value']}','0');")

                end
            end  
        end   
    
  end

  updateTest(id)
   puts ''
  
end

def deleteTestWorkflow(id,component, key, order)

if key=='key'
  $mysql.query("DELETE FROM test_workflow WHERE test_rel_id = '#{id}' and execution_order = '#{order}' and keyword_rel_id = '#{component}' and keyword = 1;")
  $mysql.query("DELETE FROM test_workflow WHERE test_rel_id = '#{id}' and execution_order = '#{order}' and keyword_rel_id = '#{component}' and keyword = 2;")
else
  $mysql.query("DELETE FROM test_workflow WHERE test_rel_id = '#{id}' and execution_order = '#{order}' and component_rel_id = '#{component}' ")

end  

  updateTest(id)
end


def saveTestDetails(id,details)

  $mysql.query("UPDATE tests SET object_description ='#{details}' WHERE object_id = '#{id}';")
  updateTest(id)

end


def getkeywordData(id)

results = []
 $mysql.query("SELECT null as parameters, keywords_workflow.id, keywords_workflow.execution_order, components.object_id,components.object_description, components.object_name FROM keywords_workflow
                    INNER JOIN components
                    ON component_rel_id = object_id
                    WHERE test_rel_id = '#{id}'
                    GROUP BY execution_order
                    ORDER BY execution_order;",:as => :json).each do |row|

        results << row

      params =[]
      $mysql.query("SELECT component_parameters.parameter_name, keywords_workflow.id,keywords_workflow.param_id,keywords_workflow.param_value
                    FROM keywords_workflow
                    INNER JOIN component_parameters
                    ON keywords_workflow.param_id = component_parameters.id
                    WHERE keywords_workflow.component_rel_id = '#{row['object_id']}'
                    AND keywords_workflow.test_rel_id = '#{id}'
                    AND keywords_workflow.execution_order = '#{row['execution_order']}';",:as => :json).each do |param|
         params << param

          end
        row['parameters'] = params

      end
      
results = results.to_json
  return results
end  

def saveTestBrowser(id,browser)

  $mysql.query("UPDATE tests SET browser ='#{browser}' WHERE object_id = '#{id}';")
  updateTest(id)
end



def getTestChartData(id) 

	results_history = []
	$mysql.query("SELECT * FROM test_history WHERE test_rel_id = '#{id}';",:as => :json).each do |row|

        results_history << row
     end
  
  results = results_history.to_json
  return results
end


