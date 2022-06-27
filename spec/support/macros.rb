# frozen_string_literal: true

def load_task(task)
  Rails.application.load_tasks
  Rake::Task[task].execute
end

def json
  result = JSON.parse(response.body)
  result.is_a?(Array) ? result : HashWithIndifferentAccess.new(result)
end

def header_params(args = {})
  {
    'X-TOKEN-ID': args[:token],
    Accept: 'Application/json',
    HTTP_ACCEPT_LANGUAGE: args[:locale] || :en,
    HTTP_X_SITE_ID: 'www.litbit.com'
  }
end

def logout_headers(args = {})
  {
    'X-TOKEN-ID': args[:token],
    Accept: 'Application/json',
    HTTP_ACCEPT_LANGUAGE: args[:locale] || 'en',
    HTTP_X_SITE_ID: args[:domain] || 'test.selise.tech',
    Cookie: "TEST-ID-TOKEN=#{args[:token]}"
  }
end

def user_token(id = 1, role_uuid = 1, role_name = 'super_admin')
  JWT.encode user_payload(id, role_uuid, role_name), ENV.fetch('JWT_SECRET', nil)
end

def login_hash(user)
  {
    user: {
      email: user.email,
      password: user.password
    }
  }
end

def tokenize(user)
  JWT.encode({ user: { uuid: user.uuid } }, ENV.fetch('JWT_SECRET', nil))
end

def user_payload(id, role_uuid, role_name)
  payload = {
    user: {
      id: id,
      email: 'nima.yonten.1729@gmail.com',
      uuid: SecureRandom.uuid,
      first_name: nil,
      last_name: nil,
      profile_attributes: nil,
      role_attributes: {
        id: 1,
        uuid: role_uuid,
        name: role_name
      }
    }
  }.to_json
  JSON.parse(payload)
end
