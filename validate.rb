require 'json'
require 'base64'
require 'digest'
require 'openssl'

def token 
  @key = 'sales-key'

  @header = [
    'typ' => 'JWT',
    'alg' => 'HS256'
  ]
  @header = JSON.generate(@header)
  @header = Base64.encode64(@header).tr('+/', '-_').gsub(/[\n=]/, '')
  
  @payload = [
    'iss' => 'salescreations.com.br',
    'username' => 'rsales',
    'email' => 'rafael.sales@salescreations.com.br'
  ]
  @payload = JSON.generate(@payload)
  @payload = Base64.encode64(@payload).tr('+/', '-_').gsub(/[\n=]/, '')
  
  @signature = OpenSSL::HMAC.digest('sha256', @key, "#{@header}.#{@payload}")
  @signature =  Base64.encode64(@signature).tr('+/', '-_').gsub(/[\n=]/, '')
  
  return "#{@header}.#{@payload}.#{@signature}"
end

recived_token = 'W3sidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifV0.W3siaXNzIjoic2FsZXNjcmVhdGlvbnMuY29tLmJyIiwidXNlcm5hbWUiOiJyc2FsZXMiLCJlbWFpbCI6InJhZmFlbC5zYWxlc0BzYWxlc2NyZWF0aW9ucy5jb20uYnIifV0.xYTqn1qCIAjB23DCBAtXtpPkcEHkGJMx4XDlWD1aYe0'

if recived_token === token
  print 'Siga em Frente!'
else
  print 'Suma daqui!'
end