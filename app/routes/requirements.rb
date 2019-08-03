get ('/Requirements') { erb :requirements }

post '/saveRequirement' do

  item = JSON.parse(request.body.read)

  id = item['elementId']
  requirement = item['requirement']

  saveRequirement(id, requirement)
end

post '/deleteRequirement' do

  item = JSON.parse(request.body.read)

  requirementId = item['requirementId']

  deleteRequirement(requirementId)

end

