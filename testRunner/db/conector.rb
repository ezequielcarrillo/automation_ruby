module Db

  $mysql = Mysql2::Client.new(:host=>'127.0.0.1', :username=>'root',:password=> 'guada15joaco5momo4', :database=>'automation',:reconnect => true,:encoding => 'utf8')

end
