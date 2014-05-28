require 'test/unit'
require './family'
require './image'

class FamilyTest < Test::Unit::TestCase
  def setup
    @family = Family.new('test')
    @family.add_image(Image.new('i2.jpg', 'images/i2.jpg', 200, 100))
    @family.add_image(Image.new('i3.jpg', 'images/i3.jpg', 300, 100))
    @family.add_image(Image.new('i1.jpg', 'images/i1.jpg', 100, 100))
  end

  def test_adding_new_images_should_resort_by_ratio
    @family.add_image(Image.new('i4.jpg', 'images/i4.jpg', 50, 100))
    assert(@family.images[0].name == 'i4.jpg') 
    assert(@family.images[1].name == 'i1.jpg')
    assert(@family.images[2].name == 'i2.jpg')
    assert(@family.images[3].name == 'i3.jpg')
  end

  def test_removing_an_image_should_work
    @family.remove_image('i2.jpg')
    assert(@family.images.length == 2)
  end
end