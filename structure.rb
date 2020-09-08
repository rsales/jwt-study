require 'json'
require 'base64'
require 'digest'
require 'openssl'

# JOSE - Json Object Signing and Encryption
# JWT - Json Web Token 
# JWE - Json Web Encryption **
# JWK - Json Web Keys
# JWA - Json Web Algorithms
# JWS - Json Web Signature **

#=======
# Key JWT
#=======
@key = 'sales-key'

#=======
# Header JWT - Informações do JWT
#=======

@header = [
  'typ' => 'JWT',
  'alg' => 'HS256'
]

@header = JSON.generate(@header)
@header = Base64.encode64(@header).tr('+/', '-_').gsub(/[\n=]/, '')

#=======
# Payload JWT - correspondente
#=======

@payload = [
  'iss' => 'salescreations.com.br',
  'username' => 'rsales',
  'email' => 'rafael.sales@salescreations.com.br'
]

@payload = JSON.generate(@payload)
@payload = Base64.encode64(@payload).tr('+/', '-_').gsub(/[\n=]/, '')

#=======
# signature JWT
#=======

@signature = OpenSSL::HMAC.digest('sha256', @key, "#{@header}.#{@payload}")
@signature =  Base64.encode64(@signature).tr('+/', '-_').gsub(/[\n=]/, '')

@token = "#{@header}.#{@payload}.#{@signature}"

# print JSON(@header)
# print "#{@header}.#{@payload}"

print @token
