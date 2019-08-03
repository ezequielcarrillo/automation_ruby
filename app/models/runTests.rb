require_relative '../../db/conector'


def testQueryBuilder(selectedid,suite_execution_id)

  results = []
 
  $mysql.query("SELECT  test_workflow.component_rel_id, test_workflow.execution_order
				FROM automation.test_workflow
				inner JOIN components
				on test_workflow.component_rel_id = components.object_id
				where test_rel_id = '#{selectedid}'
				group by component_rel_id ,execution_order
				ORDER BY execution_order;").each do |id|

    automations = []
    param = []
    compScript = []

    $mysql.query("SELECT component_parameters.component_rel_id, component_parameters.parameter_name, 
				  test_workflow.execution_order, test_workflow.param_value,
                  component_parameters.parameter_value as default_value
                  FROM automation.test_workflow
                  inner JOIN component_parameters
                  on test_workflow.param_id = component_parameters.id
                  where test_rel_id = '#{selectedid}'
                  and test_workflow.component_rel_id = '#{id['component_rel_id']}'
                  and execution_order = '#{id['execution_order']}'
                  ORDER BY execution_order ;").each do |params|

      param << params
    end

    $mysql.query("SELECT object_script, object_id FROM components
                  WHERE object_id =(select component_rel_id from test_workflow
                  where component_rel_id = '#{id['component_rel_id']}'
                  group by component_rel_id );").each do |script|

      compScript << script
    end

    $mysql.query("select object_properties.* , actions.action_name,test_workflow.param_value 
				from component_automation
				inner join object_properties
				on component_automation.element_rel_id = object_properties.object_rel_id
				inner join actions
				on component_automation.operation_rel_id = actions.id
				inner join component_parameters
				on component_automation.parameter_rel_id = component_parameters.id
				inner join test_workflow
				on test_workflow.param_id= component_parameters.id
				where test_workflow.component_rel_id =  '#{id['component_rel_id']}' 
				and test_workflow.test_rel_id = '#{selectedid}' and test_workflow.execution_order = '#{id['execution_order']}';").each do |automation|

      automations << automation
    end


    results << {:automation => automations, :parameters => param, :script => compScript}
  end

  object = results.to_json
  puts object
end

def getLibs()

  files = []
  $mysql.query("SELECT object_name from settings where object_type = 1;").each do |file_name|

    files << file_name['object_name']
  end

  data = []
  files.each do |file|

    file = File.open( $pathfolder + file, "r")
    data << file.read
    file.close

  end

  return data

end

def test_runner_service(test,test_id,suite_execution_id)

  libs = getLibs()
 # uri = URI('http://192.168.7.168:4568/runTest')
  
  uri = URI('http://127.0.0.1:4568/runTest')
  res = Net::HTTP.post_form(uri, 'q' => test, 'id' => test_id , 'suite_execution_id' => suite_execution_id,'libs' => libs)

  return res.body

end