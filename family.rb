class Family
  attr_accessor :name
  attr_reader :images

  def initialize(name)
    @name = name
    @images = []
  end

  def add_image(image)
    @images.push(image).sort! { |a,b| a <=> b }
  end

  def remove_image(name)
    @images.delete_if { |x| x.name == name }
  end
end