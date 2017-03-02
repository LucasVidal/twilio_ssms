require 'openssl'

class Encrypter
  def encrypt(plain_text, public_key)
    rsa = OpenSSL::PKey::RSA.new(public_key)
    rsa.public_encrypt(plain_text)
  end

  #should be implemented in client app
  def generate_key_pair
    cipher = OpenSSL::Cipher::Cipher.new('des3')
    rsa_key = OpenSSL::PKey::RSA.new(2048)
    {
      private_key: rsa_key.to_pem(cipher,'password'),
      public_key: rsa_key.public_key.to_pem
    }
  end
end
