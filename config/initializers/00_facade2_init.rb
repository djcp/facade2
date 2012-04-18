# Load config
begin
  facade2_config = YAML.load_file("#{Rails.root}/config/facade2.yml")
  facade2_config[Rails.env].keys.collect{|k| 
    Facade2::Application.config.send("#{k}=", facade2_config[Rails.env][k])
  }
rescue Exception => e
  puts e.inspect
  exit
end
