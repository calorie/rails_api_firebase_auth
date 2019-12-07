module RequestHelper
  def build_header(*args)
    token = build_token(*args)
    {
      'Content-Type'  => 'application/json',
      'Accept'        => 'application/json',
      'Authorization' => "Bearer #{token}",
    }
  end

  def build_token(*args)
    Firebase::Auth::IDTokenKeeper::Testing.generate_test_id_token(decoded_jwt(*args))
  end

  def decoded_jwt(sub: faked_firebase_uid, email: FFaker::Internet.email, iat: FFaker::Time.datetime.to_i, exp: iat + 3600)
    {
      'iss'            => "https://securetoken.google.com/#{ENV['FIREBASE_PROJECT_ID']}",
      'aud'            => ENV['FIREBASE_PROJECT_ID'],
      'auth_time'      => iat,
      'user_id'        => sub,
      'sub'            => sub,
      'iat'            => iat,
      'exp'            => exp,
    }
  end

  def faked_firebase_uid
    FFaker::Lorem.characters 28
  end
end
