require_relative '../../db/conector'

def  getLeftSidepanelData(location)

  results = []
  case location

    when '/Repository'

      $mysql.query("SELECT * FROM objects WHERE parent_object_id = 0;",:as => :json).each do |row|

        results << row
      end


    when '/pageObject'

      $mysql.query("SELECT * FROM components WHERE parent_object_id = 0;",:as => :json).each do |row|

        results << row
      end

    when '/keywords'

      $mysql.query("SELECT * FROM keywords WHERE parent_object_id  = 0;",:as => :json).each do |row|

        results << row
      end

    when '/Tests'

      $mysql.query("SELECT * FROM tests WHERE parent_object_id  = 0;",:as => :json).each do |row|

        results << row
      end


    when '/Suites'

      $mysql.query("SELECT * FROM suites WHERE parent_object_id  = 0;",:as => :json).each do |row|

        results << row
      end


    when '/Services'


      $mysql.query("SELECT * FROM services WHERE parent_object_id  = 0;",:as => :json).each do |row|

        results << row
      end

    when '/Libraries'
      $mysql.query("SELECT * FROM settings ;",:as => :json).each do |row|

        results << row
      end
  end
  results = results.to_json
  return results

end


def getRightSidepanelData(location)

  results = []
  case location

   
    when '/keywords'

      $mysql.query("SELECT * FROM components WHERE parent_object_id = 0;",:as => :json).each do |row|

        results << row
      end

    when '/Tests'

      $mysql.query("SELECT * FROM components WHERE parent_object_id = 0;",:as => :json).each do |row|

        results << row
      end
      $mysql.query("SELECT * FROM keywords WHERE parent_object_id = 0;",:as => :json).each do |row|
      row['browser'] = 'key'

         results << row 
      end
    when '/Suites'

      $mysql.query("SELECT * FROM tests WHERE parent_object_id = 0;",:as => :json).each do |row|

        results << row
      end

    when '/Requirements'

      $mysql.query("SELECT * FROM tests WHERE parent_object_id = 0;",:as => :json).each do |row|

        results << row
      end

  end
  results = results.to_json
  return results

end


def getTreeChildElements(location,selectedFolder)

  results = []
  case location

    when '/Repository'

      $mysql.query("SELECT * FROM objects WHERE parent_object_id = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end


    when '/pageObject'

      $mysql.query("SELECT * FROM components WHERE parent_object_id = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end

    when '/keywords'

      $mysql.query("SELECT * FROM keywords WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end

    when '/Tests'

      $mysql.query("SELECT * FROM tests WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end


    when '/Suites'

      $mysql.query("SELECT * FROM suites WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end


    when '/Services'


      $mysql.query("SELECT * FROM services WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end

  end
  results = results.to_json
  return results
end


def getRightTreeChildElements(location,selectedFolder, key)

  results = []
  case location

    when '/pageObject'

      $mysql.query("SELECT * FROM objects WHERE parent_object_id = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end


    when '/keywords'

      $mysql.query("SELECT * FROM components WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end

    when '/Tests'
      if key == 'key'
            $mysql.query("SELECT * FROM keywords WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

              results << row
            end
      else
        
            $mysql.query("SELECT * FROM components WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

              results << row
            end
   end
    when '/Suites'

      $mysql.query("SELECT * FROM tests WHERE parent_object_id  = '#{selectedFolder}';",:as => :json).each do |row|

        results << row
      end

  end
  results = results.to_json
  return results
end

def updateWebElementName(elementId,elementNewName)
  $mysql.query("UPDATE objects SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")
end 

def updateElementName(location,elementId,elementNewName)

  case location

    when '/Repository'

      $mysql.query("UPDATE objects SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")


    when '/pageObject'

      $mysql.query("UPDATE components SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")


    when '/keywords'

      $mysql.query("UPDATE keywords SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")

    when '/Tests'

      $mysql.query("UPDATE tests SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")


    when '/Suites'

      $mysql.query("UPDATE suites SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")

    when '/Requirements'

      $mysql.query("UPDATE requirements SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")

    when '/Settings'

      name =[]
      $mysql.query("SELECT object_name FROM settings WHERE object_id= '#{elementId}';").each do |row|

        name << row['object_name']
      end

      $mysql.query("UPDATE settings SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")

      File.rename('./'+name[0], './'+elementNewName)

    when '/Services'


      $mysql.query("UPDATE services SET object_name = '#{elementNewName}' WHERE object_id= '#{elementId}';")

  end
end


def removeSelectedElement(location,elementId)

  case location

    when '/Repository'

      $mysql.query("DELETE FROM objects WHERE object_id = '#{elementId}';")


    when '/pageObject'

      #delete component
      $mysql.query("DELETE FROM components WHERE object_id = '#{elementId}';")
      #delete parameters
      $mysql.query("DELETE FROM component_parameters WHERE component_rel_id  = '#{elementId}';")
      #delete action
      $mysql.query("DELETE FROM component_automation WHERE component_rel_id  = '#{elementId}';")
      #delte test dependencie
      $mysql.query("DELETE FROM test_workflow WHERE component_rel_id  = '#{elementId}';")

    when '/keywords'

      $mysql.query("DELETE FROM keywords WHERE object_id = '#{elementId}';")
      #delete test dependencies
     # $mysql.query("DELETE FROM test_workflow WHERE test_rel_id  = '#{elementId}';")


    when '/Tests'

      $mysql.query("DELETE FROM tests WHERE object_id = '#{elementId}';")
      #delete test requirement
      $mysql.query("DELETE FROM requirements WHERE test_rel_id = '#{elementId}';")
      #delete test dependencies
      $mysql.query("DELETE FROM test_workflow WHERE test_rel_id  = '#{elementId}';")


    when '/Suites'

      $mysql.query("DELETE  FROM suites WHERE object_id = '#{elementId}';")
      #delete test Dependencie
      $mysql.query("DELETE FROM suite_dependencies WHERE suite_id  = '#{elementId}';")


    when '/Requirements'

      $mysql.query("DELETE  FROM requirements WHERE object_id = '#{elementId}';")

    when '/Services'

      $mysql.query("DELETE services WHERE object_id = '#{elementId}';")

    when '/Libraries'

      $mysql.query("DELETE FROM settings WHERE object_id = '#{elementId}';")

  end
end


def removeSelectedWebElement(elementId)
    $mysql.query("DELETE FROM objects WHERE object_id = '#{elementId}';")
end