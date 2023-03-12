module ResponseGenerator
  extend ActiveSupport::Concern

  def success(body = nil)
    return if body.nil?

    {
      body:,
      status: 200
    }
  end

  def validation_error(errors = [])
    {
      body: {
        'title': 'params not validated.',
        'invalid-params': errors
      },
      status: 400
    }
  end

  def un_authorized_error
    {
      body: {
        'title': 'unauthorized.'
      },
      status: 401
    }
  end

  def not_found
    {
      body: {
        'title': 'resource not found.'
      },
      status: 404
    }
  end

  def db_error
    {
      body: {
        'title': 'db operations failed.'
      },
      status: 500
    }
  end

  module_function :success, :validation_error, :un_authorized_error, :not_found, :db_error
end
