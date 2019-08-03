require_relative '../../db/conector'

def uploadLibrary(tempfile, filename)

  randomNumber = Random.new
  randomNameNumber = randomNumber.rand(100000000..9900000000)


  #FileUtils.copy(tempfile.path, $pathfolder + "#{filename}")
  FileUtils.copy(tempfile.path, $pathfolder + "#{filename}")

  $mysql.query("INSERT INTO settings (object_name, object_type) VALUES ('#{filename}','1');")

end

def uploadScreenshot(tempfile, filename, component_id)
  randomNumber = Random.new
  randomNameNumber = randomNumber.rand(100000000..9900000000)
  FileUtils.copy(tempfile.path, $pathfolder + "#{filename}")
  $mysql.query("UPDATE components SET object_screenshot_name ='#{filename}' WHERE object_id ='#{component_id}';")
end

def getAttachedFileName(id)

  results = []

  $mysql.query("SELECT object_screenshot_name FROM components  WHERE object_id ='#{id}';").each do |row|

    results << row['object_screenshot_name']
  end

  return results[0]
end
