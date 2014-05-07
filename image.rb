require 'mini_magick'

class Image
  attr_accessor :name, :path, :width, :height

  def initialize(name, path, width, height)
    @name = name
    @path = path
    @width = width
    @height = height
  end

  def area
    @area ||= @width * @height
  end

  def format
    File.extname(@name)
  end

  def orientation
    @orientation ||= Image.get_orientation(@width, @height)
  end

  def ratio
    @ratio ||= @width.to_f / @height
  end

  # This number is used in determining matches to image requests.
  def match_rating
    @match_rating ||= area.to_f / ratio
  end

  def crop(width, height)
    image = MiniMagick::Image.open(@path)
    dimensions = "#{width}x#{height}"
    image.combine_options do |command|
      command.gravity("Center")
      command.extent(dimensions)
    end
    return image
  end

  def <=> other
    if self and other
      ratio <=> other.ratio
    else
      1
    end
  end

  def self.get_orientation(width, height)
    if width > height
      :landscape
    elsif width < height
      :portrait
    else
      :square
    end
  end
end