require_relative '../../db/conector'
module Commons

  def timeNow()
    return Time.new
  end

  def user()
    getUserName()
  end

end


os =  ENV['os']
if os == 'Windows_NT'
  #$pathfolder = 'C:\\Users\\ecarrillo\\Desktop\\z_uploads\\'
   $pathfolder = '../../uploads'
else
  $pathfolder = '/home//sgi-root//baf_uploads//'
end