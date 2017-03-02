require 'sinatra'
require 'sequel'
require 'sinatra/sequel'

configure :development do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'ssms_server', pool: 2, username: 'lvidal', password: 'password'}
  DB = Sequel.connect('postgres://lvidal@localhost/ssms_server')
end

configure :production do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'ssms_server', pool: 2, username: 'lvidal', password: 'password'}
  DB = Sequel.connect('postgres://lvidal@localhost/ssms_server')
end

# Create table if it does not exists
if !database.table_exists?('users')
	puts "The users table doesn't exist. Creating." 
	migration "create users table" do
	  database.create_table :users do
	    primary_key :id
	    text        :username
	    text        :phone_number
	    text        :public_key
	    timestamp   :date_added, :null => false
	    index :user_name, :unique => true
	  end
	end
end

class Database
	def store_public_key(username, phone_number, public_key)
		dataset = DB[:users]
		if dataset.where(:username => username).empty?
			dataset.insert(
				:username => username, 
				:public_key => public_key,
				:phone_number => phone_number,
				:date_added => Time.now
			)
		else
			dataset.where(:username => username).update(
				:public_key => public_key,
				:phone_number => phone_number,
				:date_added => Time.now
			)
		end
	end

	def public_key(user_name)
		dataset.where(:username => username)[:public_key]
	  #"-----BEGIN PUBLIC KEY----- \nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuZ0Klb0iuEkVs/C1k63t Tft3+/ax56tqFYrXNAYGLPKdOPF/TtzLgkjATjzMqD/V0qhR024ojEXT1nWYvTDy lUEQj2TwoTmxxzRRpdRCLfeiQTtqHBgSu/gIoUxnF6sRxbNu4G2ZOKxcutLQZ/vX KSR8kM84u88k1D703pR1YWoClhDX6dOH1fxCOzyD1DYwldWLUTYp8fsefdMtbMkT e71t0qVYDTrrSfKS2J97Sk0CdUpbBKvdEgpV/b0dunMFUuXv3O3QJjtvFQyoNWuA lmDrL/aqoU69G8998BlozvV7fnM83zL+Qbh6TiRigyeSSUI7UIEimAtn2a5SwbQA vQIDAQAB \n-----END PUBLIC KEY-----"
	end

	# (not to be used here)
	def private_key
	  '-----BEGIN RSA PRIVATE KEY----- Proc-Type: 4,ENCRYPTED DEK-Info: DES-EDE3-CBC,3D37CD3A313CADA2 7c1TAxzv6Gn2OmZzVNtEnU9lqrEwRL65huGc9ewQQ7senY3rkBgIqBzqVarAfS0I 6OMimI57q7XywAiFn7CZ+L7fbXdNuvmGx5JDNRwylgGWR+hPi9JMKEAP1yjdJPRS 608pDXIliz5bO0GdvufQxQ91MPjE4Bs5AT8TIE3bzuFllBYJD/mLpkK4bOjLHswI 7W7afVctpYaRAwzb64Z+gUQZL0BIcQzG2wYvFU3vAs5sCtEy9o7riY/bBi78EEH6 go01DkgYLt8M7ApTwblJNJR0G/8bwy3oDgdieM42sFLzftxwjeBhIiF1ExH+KuYA ftAcROOfr8rduvNNc6jJcx2lyze+4joPjHDBXZr27bg3o3SwOQCIXUHe0DHG0PHn TbZkL2btHH36mTMq0j6P9R4t1wLhJ8Pq2LjLDwLhXw3Tb8aIX1tpShxyy9Yv8F84 Q6dfBLe4yqmvW1Db2nGmZ++gPua2OGWuNXwjivt2XrZ0fGAGri5j9bsqyvDsHwUS aRs8PaG97rgmyRGHYUoicBdgeFZhBHSLlU5F6RNUTOgK9QAHP4+bdKbMQxvhveh8 +v9o7Xa7BlqEvUYXIfBwEbHZoJx4t90XSndSS3chlfoEb6vcxOBmplUZlWs55aSL U7dW1MaE48Afav6TtM2VsN9RzwU8QSplpm7z9C9xkYVBMN6UcKIbnHH1yXdhTGEG uaEvPrtSh+BroAx1OmMjkmb0s1PjgDqLEtaYifP1OXgSS3uTqPBcpgUZDnuYQZmW Ihv7SvGdyWVQUgpv5LukyZPhXdlsCQ+8TlEYn4MOl87uxqo3KCVzVdmhAx2PWS/q wLcyOq0wJuvgAAtmI4/EnXVaP5P6WQ7rixfxdDfR1nI5TnDQkgs2xquyb0cms0J+ hXkIGvQOMAzq2Js3Ad7qyiklDASR20zZt6JPKTgZpLq682Fx+LJCCryAqjye2nAI 0w5SHEd80J/lAUEYo/HrNDBWS0JzD4lfERwUxgXxvynFI1ak38h0YP9RR2ka0pMI DJ8G6/w3Ir1qgLM/E+bTvp1YE683J/j1+vdYC/eoAbki2wgJAitYFdexLpw/qMvj xonY4iyhVkgzQb0GObesjPhr0CQ1gRC8p/A68Pk4cXejKTO95gUnD682Mu6lgYXQ e3rEnNVUruiPEzMKbkPLIsaWfUKfGRb0okQmuISXEfjyLfjkUgD6bxes+9KuHdvj pZze3dOgB1W6ZGsbrQ8ooXAOewYbhDcEqVsPOItVBoZ14CmCSd1X8RiW1dnfZBLa 5W8L7HaVLgiKUWlu2N6BE3etMK/fzhLh1K8WT6PxqzqVfJZZ9TYwVSYbcJuej0Hf ioHwYgqO22aZrp+ciJplCyOooFOKVVW45iLPtSHX64aE6FKbdPEPcndIOl0J9ah0 Hwicaw0ADP4STb83NysAZdHO2UVNEERkp2P4XmgeeH3gYHhPv3xCbbDejrrRJjeq VRer8i6HxiuJ/SxNKvbiwztF/44nWJ+9m2FoNqumTITdQAx7VU3681uEsO9ZbsJU Lbt0zwxna4X6WEtjdy5ExqLlU+wnzWgG+I11vgXSarye2oTuGPK8wjBkfEqdRTxs -----END RSA PRIVATE KEY----- '
	end

	def all_users
		DB[:users].all
	end
end
