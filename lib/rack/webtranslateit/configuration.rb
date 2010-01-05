require 'yaml'

class Rack::Webtranslateit::Configuration
  attr_accessor :api_key, :autofetch, :files, :ignore_locales

  def initialize
    file = File.join(RAILS_ROOT, 'config', 'translation.yml')
    configuration       = YAML.load_file(file)
    self.api_key        = configuration['api_key']
    self.autofetch      = configuration[RAILS_ENV]['autofetch']
    self.files          = []
    self.ignore_locales = [configuration['ignore_locales']].flatten.map{ |l| l.to_s }
    configuration['files'].each do |file_id, file_path|
      self.files.push(Rack::Webtranslateit::TranslationFile.new(file_id, file_path, api_key))
    end
  end

  def locales
    http              = Net::HTTP.new('webtranslateit.com', 443)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    http.read_timeout = 10
    request           = Net::HTTP::Get.new("/api/projects/#{api_key}/locales")
    response          = http.request(request)
    if response.code.to_i == 200
      response.body.split
    else
      []
    end
  end
end
