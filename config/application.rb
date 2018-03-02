require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Zaro
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # config.active_record.raise_in_transactional_callbacks = true
    # config.autoload_paths += %W(#{config.root}/app/uploaders)
    #調整時區
    #預設是 UTC。在 Rails 中，資料庫裡面儲存的時間皆為 UTC 時間，而設定此時區會自動幫你處理轉換動作。
    #例如設定 Taipei 的話，從資料庫讀取出來時會自動加八小時，存進資料庫時會自動減八小時。    
    config.time_zone = "Taipei"
    #另新增 modul 在 lib/目錄下面
    # Autoload lib/ folder including all subdirectories
    # config.autoload_paths += Dir["#{config.root}/lib/**"] 
    config.eager_load_paths << "#{Rails.root}/lib/modules"
    # config.eager_load_paths += %W(#{config.root}/lib/modules)
    # config.autoload_paths += %W(#{config.root}/lib/modules)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
