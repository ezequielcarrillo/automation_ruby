require_relative '../../db/conector'


def  saveRequirement(id, requirement)

  $mysql.query("INSERT INTO requirements (test_rel_id,requirement, created_at, created_by) VALUES('#{id}','#{requirement}','#{Time.new}','#{getUserName()}');")

end

def deleteRequirement(requirementId)

  $mysql.query("DELETE FROM requirements WHERE id = '#{requirementId}';")

end


