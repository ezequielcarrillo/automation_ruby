require_relative '../../db/conector'

 # gem install ruby-net-ldap


  ### BEGIN CONFIGURATION ###
  SERVER = '192.168.6.3'         # Active Directory server name or IP
  PORT = 389                     # Active Directory server port (default 389)
  BASE = 'DC=Belatrix,DC=com'    # Base to search from
  DOMAIN = 'Belatrix.com'        # For simplified user@domain format login
  ### END CONFIGURATION ###
    
  def authenticate(login, pass)

	return false if login.empty? or pass.empty?
=begin
	conn = Net::LDAP.new :host => SERVER,
						 :port => PORT,
						 :base => BASE,
						 :auth => { :username => "#{login}@#{DOMAIN}",
									:password => pass,
									:method => :simple }
							
=end									
	if pass = '1' #conn.bind	
	  key = SecureRandom.hex(70)	
	  response.set_cookie(:'sap',:value => key,:path => '/',:httponly => true, :expires => Time.now + 1800, :secret => 'xxxx' )
	  session[:user_id] = login
	  session[:user_key] = key
	  
	  return true
	else
	  return false
	end

  # If we don't rescue this, Net::LDAP is decidedly ungraceful about failing
  # to connect to the server. We'd prefer to say authentication failed.
  rescue Net::LDAP::LdapError => e
	puts e
	return false
  end

	
def getUserName()
  if session[:user_key] == request.cookies['sap']
	return session[:user_id]
  end
end

def logged?
 return false if request.cookies['sap'].nil?
 if session[:user_key] == request.cookies['sap']
	return true
  end
end

def authenticated! ; if logged?; return true else redirect ('/') end end

def session_logout()

  return response.delete_cookie("sap")
end

def getSvnRevision()
	number = %x[svn info |grep Revision: | cut -c11-]
	date = %x[svn info |grep 'Last Changed Date': | cut -c45-]
	return "#{number}" +' '+"#{date}"
end