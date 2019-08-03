require_relative '../../db/conector'
require_relative 'commons'

def saveObjectProperties(id, locator, locatorValue)
p id 
p locator
p locatorValue
  results =[]
  $mysql.query("SELECT * FROM object_properties WHERE object_rel_id = '#{id}'").each do |result|

     results << result

  end

    if results.empty? == true

       $mysql.query("INSERT INTO object_properties
                  (object_rel_id, locator , locator_value)
                  VALUES('#{id}','#{locator}','#{locatorValue}');")
     else

       $mysql.query("UPDATE object_properties SET locator = '#{locator}', locator_value ='#{locatorValue}'
                  WHERE object_rel_id = '#{id}';")
       $mysql.query("UPDATE object_properties SET locator = '#{locator}', locator_value ='#{locatorValue}'
                  WHERE copy_of = '#{id}';")           

   end

  $mysql.query("UPDATE objects SET modified_at ='#{Time.new}', modified_by = '#{getUserName()}' WHERE object_id = '#{id}';")

end

def saveObjectDetails(id, details)

  $mysql.query("UPDATE objects SET object_description ='#{details}' WHERE object_id = '#{id}';")
  $mysql.query("UPDATE objects SET modified_at ='#{Time.new}', modified_by = '#{getUserName()}' WHERE object_id = '#{id}';")

end