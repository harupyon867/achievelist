module TokenHandler
  extend ActiveSupport::Concern

  def generate_access_token(subject)
    config = Achievelist::Application.config.x
    rsa_private = File.open(config.filepath_private_key, 'r').read
    private_key = OpenSSL::PKey::RSA.new(rsa_private)

    exipire_access = config.jwt.expiration_minutes_access.to_i.minute

    JWT.encode(
      { iss: config.jwt.issuer,
        sub: subject,
        exp: Time.current.since(exipire_access).to_i },
      private_key,
      'RS256'
    )
  end

  def generate_refresh_token(subject)
    config = Achievelist::Application.config.x
    rsa_private = File.open(config.filepath_private_key, 'r').read
    private_key = OpenSSL::PKey::RSA.new(rsa_private)

    exipire_refresh = config.jwt.expiration_minutes_refresh.to_i.minute

    JWT.encode(
      { iss: config.jwt.issuer,
        sub: subject,
        exp: Time.current.since(exipire_refresh).to_i },
      private_key,
      'RS256'
    )
  end

  def decode_token(token)
    config = Achievelist::Application.config.x
    rsa_public = File.open(config.filepath_public_key, 'r').read
    public_key = OpenSSL::PKey::RSA.new(rsa_public)

    begin
      decoded_token = JWT.decode(token, public_key, true, { algorithm: 'RS256' })
    rescue JWT::VerificationError => e
      puts e.message
      Rails.logger.info(e)
      return false
    rescue JWT::ExpiredSignature => e
      Rails.logger.info(e)
      return false
    end

    decoded_token
  end

  module_function :generate_access_token, :generate_refresh_token, :decode_token
end
