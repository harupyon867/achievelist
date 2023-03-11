module ResponseGenerator
  extend ActiveSupport::Concern

  def success(body = nil)
    return if body.nil?

    body
  end

  def validation_error(errors = [])
    {
      'title': 'params not validated.',
      'invalid-params': errors
    }
  end

  def un_authorized_error
    {
      'title': 'unauthorized.'
    }
  end

  def db_error
    {
      'title': 'db operations failed.'
    }
  end

  module_function :success, :validation_error, :un_authorized_error, :db_error
end
