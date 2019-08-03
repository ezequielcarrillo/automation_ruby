require_relative '../../db/conector'
require_relative 'commons'

def addNewElement( itemName, itemType, itemClass, itemParentId )

  created_at = Time.new
  created_by = getUserName()

  case itemClass

    when '/Repository'

      $mysql.query("INSERT INTO objects (object_name,object_type, created_at, created_by, parent_object_id) VALUES('#{itemName}','#{itemType}','#{created_at}','#{created_by}','#{itemParentId}');")

    when '/pageObject'

      $mysql.query("INSERT INTO components (object_name,object_type, created_at, created_by, parent_object_id) VALUES('#{itemName}','#{itemType}','#{created_at}','#{created_by}','#{itemParentId}');")

    when '/keywords'
    
      $mysql.query("INSERT INTO keywords (object_name,object_type, created_at, created_by, parent_object_id, browser) VALUES('#{itemName}','#{itemType}','#{created_at}','#{created_by}','#{itemParentId}','key');")

    when '/Tests' 

      $mysql.query("INSERT INTO tests (object_name,object_type, created_at, created_by, parent_object_id) VALUES('#{itemName}','#{itemType}','#{created_at}','#{created_by}','#{itemParentId}');")

    when '/Suites'

      $mysql.query("INSERT INTO suites (object_name,object_type, created_at, created_by, parent_object_id) VALUES('#{itemName}','1','#{created_at}','#{created_by}','#{itemParentId}');")

    when '/Services'

      $mysql.query("INSERT INTO services (object_name,object_type, created_at, created_by, parent_object_id) VALUES('#{itemName}','#{itemType}','#{created_at}','#{created_by}','#{itemParentId}');")

  end

end


def addNewWebElement(itemName, itemType, itemClass, itemParentId )
      created_at = Time.new
      created_by = getUserName()
      $mysql.query("INSERT INTO objects (object_name,object_type, created_at, created_by, parent_object_id) VALUES('#{itemName}','#{itemType}','#{created_at}','#{created_by}','#{itemParentId}');")

end