post '/runTest' do

  test = params[:q]
  test_id = params[:id]
  libs = params[:libs]
  suite_execution_id = params[:suite_execution_id]
  
  execute_test(test,test_id, libs,suite_execution_id)

end