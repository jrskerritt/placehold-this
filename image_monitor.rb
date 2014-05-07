require 'singleton'
require 'mini_magick'
require './family'
require './image'

class ImageMonitor
  include Singleton

  attr_accessor :image_paths, :families

  def initialize
    @families = Hash.new
    @image_paths = []
  end

  def add_image(path)
    family_name = get_family_name(path)
    file_name = get_file_name(path)
    image = MiniMagick::Image.open(path)

    unless @families.has_key?(family_name)
      @families[family_name] = Family.new(family_name)
    end

    @families[family_name].add_image(file_name, path, image[:width].to_i, image[:height].to_i)
  end

  def remove_image(path)
    family_name = get_family_name(path)
    file_name = get_file_name(path)

    unless @families.has_key?(family_name)
      return
    end

    family = @families[family_name]
    family.remove_image(file_name)

    # remove the family if it's empty now
    if family.images.length == 0
      @families.delete(family_name)
    end
  end

  private
  def get_family_name(path)
    return path =~ %r{images/[^/]+\..{2,4}$} ? "" : %r{images/([^/]+)/}.match(path).captures[0]
  end

  def get_file_name(path)
    return %r{/([^/]+)$}.match(path).captures[0]
  end
end