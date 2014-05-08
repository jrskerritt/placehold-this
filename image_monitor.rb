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
    @global = ""
    @families[@global] = Family.new(@global)
  end

  def add_image(path)
    family_name = get_family_name(path)
    file_name = get_file_name(path)
    image = MiniMagick::Image.open(path)
    image_obj = Image.new(file_name, path, image[:width].to_i, image[:height].to_i);

    # Always add to the global family. If the path is the root images directory,
    # don't add to the global family twice.
    @families[@global].add_image_obj(image_obj)
    if @families[@global].name == family_name then return end

    # Otherwise add to the other non-global family too
    unless @families.has_key?(family_name)
      @families[family_name] = Family.new(family_name)
    end
    @families[family_name].add_image_obj(image_obj)
  end

  def remove_image(path)
    family_name = get_family_name(path)
    file_name = get_file_name(path)

    # Always remove from the global family first
    @families[@global].remove_image(file_name)
    if @families[@global].name == family_name then return end

    @families[family_name].remove_image(file_name)

    # remove the family if it's empty now
    if @families[family_name].images.length == 0
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