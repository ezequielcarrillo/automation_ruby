require_relative '../../db/conector'
require_relative 'commons'

def getSelectedElementData(location,id)

  results = []

  case location

    when '/Repository'

      dependencies = []

      $mysql.query("SELECT * FROM objects  INNER JOIN object_properties ON object_id = object_rel_id WHERE object_id = '#{id}';").each do |row|

        results << row
      end

      $mysql.query("SELECT component_rel_id, components.object_name,components.created_at,components.created_by
                  FROM component_automation
                  INNER JOIN components
                  ON component_rel_id = object_id
                  WHERE component_automation.element_rel_id  = '#{id}'
                  GROUP BY object_name;").each do |dep|

        dependencies << dep
      end

      results <<  {:dependencies => dependencies}
    when '/pageObject'

      param = []
      auto = []
      dependencies = []
      dependencies_keywords = []
      operations = []

      $mysql.query("SELECT * FROM components WHERE object_id = '#{id}';").each do |row|

        results << row
      end

      $mysql.query("SELECT * FROM component_parameters WHERE component_rel_id = '#{id}';").each do |row|

        param <<  row
      end

      $mysql.query("SELECT tests.object_name, tests.created_by, tests.created_at FROM tests
                    INNER JOIN test_workflow
                    ON test_rel_id = object_id
                    WHERE component_rel_id = '#{id}'
                    GROUP BY object_name;").each do |row|
        dependencies <<  row
      end

     $mysql.query("SELECT keywords.object_name, keywords.created_by, keywords.created_at FROM keywords
                    INNER JOIN keywords_workflow
                    ON test_rel_id = object_id
                    WHERE component_rel_id = '#{id}'
                    GROUP BY object_name;").each do |row|
        dependencies_keywords <<  row
      end


      $mysql.query("
              SELECT component_automation.id, component_automation.assert,objects.object_id, objects.object_name,
              actions.id as action_id, actions.action_name,
              component_parameters.id as param_id,
              component_parameters.parameter_name
              FROM component_automation
              INNER JOIN objects
              ON element_rel_id = object_id
              INNER JOIN actions
              ON operation_rel_id = actions.id
              INNER JOIN component_parameters
              ON parameter_rel_id = component_parameters.id
              WHERE component_automation.component_rel_id = '#{id}';").each do |row|
        auto <<  row
      end

        $mysql.query("
                select component_automation.id,objects.object_id, objects.object_name,
                actions.id as action_id, actions.action_name
                FROM component_automation
                INNER JOIN objects
                ON element_rel_id = object_id
                INNER JOIN actions
                ON operation_rel_id = actions.id
                WHERE (component_automation.component_rel_id = '#{id}'
                and parameter_rel_id = -1 or parameter_rel_id = '');").each do |row|
          auto <<  row
      end

      $mysql.query("SELECT * FROM actions;",:as => :json).each do |operation|

        operations << operation

      end

      results <<  {:parameters => param , :automation => auto, :dependencies => dependencies,:dependencies_keywords => dependencies_keywords, :operations => operations }

##still some work to do

    when '/keywords'

      dependencies = []
      coverage = []
      workflow = []
	    results_history = []

      $mysql.query("SELECT * FROM keywords WHERE object_id = '#{id}';",:as => :json).each do |row|

        results << row
      end
      $mysql.query("SELECT tests.object_name, tests.created_by, tests.created_at FROM tests
                    INNER JOIN test_workflow
                    ON test_rel_id = object_id
                    WHERE keyword_rel_id = '#{id}'
                    GROUP BY object_name;",:as => :json).each do |row|

        dependencies << row
      end

      $mysql.query("SELECT requirement FROM requirements WHERE test_rel_id = '#{id}';",:as => :json).each do |row|

        coverage << row
      end

      $mysql.query("SELECT null as parameters, keywords_workflow.id, keywords_workflow.execution_order, components.object_id,components.object_description, components.object_name FROM keywords_workflow
                    INNER JOIN components
                    ON component_rel_id = object_id
                    WHERE test_rel_id = '#{id}'
                    GROUP BY execution_order
                    ORDER BY execution_order;",:as => :json).each do |row|

        workflow << row

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
      
      results << {:dependencies => dependencies, :coverage => coverage, :workflow => workflow}

    when '/Tests'

      dependencies = []
      coverage = []
      workflow = []
	    results_history = []

      $mysql.query("SELECT * FROM tests WHERE object_id = '#{id}';",:as => :json).each do |row|

        results << row
      end
      $mysql.query("SELECT * FROM suite_dependencies
                    INNER JOIN suites ON object_id = suite_id WHERE test_rel_id = '#{id}'
                     GROUP BY object_name;",:as => :json).each do |row|

        dependencies << row
      end

      $mysql.query("SELECT requirement FROM requirements WHERE test_rel_id = '#{id}';",:as => :json).each do |row|

        coverage << row
      end

## select keywords
 
 
$mysql.query("SELECT null as parameters, test_workflow.id, test_workflow.execution_order, keywords.object_id, keywords.browser, keywords.object_name, keywords.object_description FROM test_workflow
                    INNER JOIN keywords
                    ON keyword_rel_id = object_id
                    WHERE test_rel_id = '#{id}'
                    and test_workflow.keyword = 1
                    GROUP BY execution_order
                    ORDER BY execution_order;",:as => :json).each do |keyword|

        workflow << keyword
         
        functions=[]
       
         $mysql.query("SELECT null as functions, keywords_workflow.id, keywords_workflow.execution_order, components.object_id,components.object_description, components.object_name FROM keywords_workflow
                    INNER JOIN components
                    ON component_rel_id = object_id
                    WHERE test_rel_id = '#{keyword['object_id']}'
                    GROUP BY execution_order
                    ORDER BY execution_order;",:as => :json).each do |function|
              keyword['functions'] = functions << function     

        
                  
                      params=[]
                      $mysql.query("SELECT component_parameters.parameter_name,component_parameters.parameter_description, test_workflow.id,test_workflow.param_id,test_workflow.param_value
                                    FROM test_workflow
                                    INNER JOIN component_parameters
                                    ON test_workflow.param_id = component_parameters.id
                                    WHERE test_workflow.component_rel_id = '#{function['object_id']}'
                                    AND test_workflow.test_rel_id = '#{id}'
                                    AND test_workflow.execution_order = '#{keyword['execution_order']}'
                                    AND test_workflow.keyword = 2;",:as => :json).each do |param|
                                            
                      function['parameters'] = params << param
                      
                          end
 
              end       
             
end
##end select keywords

      $mysql.query("SELECT null as parameters, test_workflow.id, test_workflow.execution_order, components.object_id, components.object_name FROM test_workflow
                    INNER JOIN components
                    ON component_rel_id = object_id
                    WHERE test_rel_id = '#{id}' and keyword = 0
                    GROUP BY execution_order
                    ORDER BY execution_order;",:as => :json).each do |row|

        workflow << row

      params =[]
      $mysql.query("SELECT component_parameters.parameter_name,component_parameters.parameter_description , test_workflow.id,test_workflow.param_id,test_workflow.param_value
                    FROM test_workflow
                    INNER JOIN component_parameters
                    ON test_workflow.param_id = component_parameters.id
                    WHERE test_workflow.component_rel_id = '#{row['object_id']}'
                    AND test_workflow.test_rel_id = '#{id}'
                    AND test_workflow.execution_order = '#{row['execution_order']}'
                    AND test_workflow.keyword = 0;",:as => :json).each do |param|
         params << param

          end
        row['parameters'] = params


      end

	  $mysql.query("SELECT * FROM test_history WHERE test_rel_id = '#{id}';",:as => :json).each do |row|

        results_history << row
      end
      
      results << {:dependencies => dependencies, :coverage => coverage, :workflow => workflow, :results_history => results_history}

when '/Suites'
       tests=[]

        $mysql.query("SELECT * FROM suites WHERE object_id = '#{id}';",:as => :json).each do |row|

          results << row
        end
        $mysql.query("SELECT *, null as result FROM suite_dependencies
                      INNER JOIN tests ON object_id = test_rel_id
                      WHERE suite_id = '#{id}';",:as => :json).each do |row|

          tests << row

            $mysql.query("SELECT time_stamp, result, error_log, test_status
                        FROM test_history
                        WHERE test_rel_id = '#{row['test_rel_id']}'
                        ORDER BY time_stamp DESC LIMIT 1;").each do |test_result|
              row['result'] = test_result
            end

        end
        results <<  {:tests => tests}

    when '/Libraries'

      fileName=[]
      $mysql.query("SELECT * FROM settings WHERE object_id = '#{id}';",:as => :json).each do |row|

        fileName << row['object_name']
      end

      file = File.open( '../../uploads' +fileName[0], "r")
      data = file.read
      file.close

      results <<  {:text => data}

    when '/Requirements'

        $mysql.query("SELECT * FROM requirements WHERE test_rel_id = '#{id}';",:as => :json).each do |row|

          results << row
        end

  end

  results = results.to_json
  return results

end


def  getPageObjectWebElements(id)

   results = []
  $mysql.query("SELECT * FROM objects WHERE parent_object_id = '#{id}';",:as => :json).each do |row|

    results << row
 
  end
 results = results.to_json
  return results
  end