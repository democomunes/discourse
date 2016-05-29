# We have had lots of config issues with SECRET_TOKEN to avoid this mess we are moving it to redis
#  if you feel strongly that it does not belong there use ENV['SECRET_TOKEN']
#
token = "2a262e5a3fa362f6dd3796c793f19ca8b5bd7953767bca3af46726f079cc7fa179c75945f95e3d6c99d4e3eca9b62acad2386848605926cb73127bc27ff24555"
unless token
  token = $redis.get('SECRET_TOKEN')
  unless token && token.length == 128
    token = SecureRandom.hex(64)
    $redis.set('SECRET_TOKEN',token)
  end
end

Discourse::Application.config.secret_token = token
Discourse::Application.config.secret_key_base = token
