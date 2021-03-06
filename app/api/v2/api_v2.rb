require 'grape'
require 'grape-swagger'

require_relative 'sessions_api_v2'
require_relative 'services_api_v2'
require_relative 'products_api_v2'
require_relative 'projects_api_v2'
require_relative 'users_api_v2'
require_relative 'github_api_v2'
require_relative 'security_api_v2'

module V2
  class ApiV2 < Grape::API
    #version "v2", using: :path
    content_type :json, 'application/json'

    format :json
    default_format :json

    #rescue_from :all #comment out if you want to see RAILS error pages & debug on cmd-line
    mount SessionsApiV2
    mount ServicesApiV2
    mount ProductsApiV2
    mount ProjectsApiV2
    mount OrganisationsApiV2
    mount UsersApiV2
    mount GithubApiV2
    mount SecurityApiV2

    env        = Settings.instance.environment
    server_url = GlobalSetting.get( env, 'server_url' )
    server_url = 'https://www.versioneye.com' if env.to_s.eql?('production')
    server_url = 'http://127.0.0.1:3000' if env.to_s.eql?('test')
    server_url = 'http://127.0.0.1:3000' if server_url.to_s.empty?

    base_url = "#{server_url}/api/v2"
    ENV['API_BASE_PATH'] = base_url

    add_swagger_documentation(
      :base_path => "/api/v2",
      :class_name => "swagger_doc2",
      :mount_path => "/swagger_doc",
      :doc_version => "2.0",
      :markdown => false,
      :hide_format => true,
      :hide_documentation_path => true,
      :info => {
        :title => "Available API endpoints",
      }
    )

    before do
      header "Access-Control-Allow-Origin", "*"
      header "Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, PATCH, DELETE"
      header "Access-Control-Request-Method", "*"
      header "Access-Control-Max-Age", "1728000" # round about 20 days
      header "Access-Control-Allow-Headers", "api_key, Content-Type"

    end

    get '/' do
      'GRAPE LIVES HERE'
    end

  end
end
