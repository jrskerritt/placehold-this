require 'sinatra'
require 'sinatra/config_file'
require 'guard'
require './image_monitor'
require './image_selector'

config_file 'config.yml'
set :port, settings.port

def get_image(family_name, width, height)
  Guard.run_all
  monitor = ImageMonitor.instance
  family = monitor.families[family_name]
  image = ImageSelector.new.select(family, width, height)

  unless image then halt 404 end
  send_file(image.crop(width, height).path, :disposition => "inline")
end


# Display an image from the default family (images in the root images folder)
get '/:width/?:height?' do
  width = params[:width].to_i
  height = (params[:height] || width).to_i

  get_image("", width, height)
end

# Display an image from a family
get '/:family/:width/?:height?' do 
  family_name = params[:captures][0]
  width = params[:width].to_i
  height = (params[:height] || width).to_i

  get_image(family_name, width, height)
end

Guard.run_all