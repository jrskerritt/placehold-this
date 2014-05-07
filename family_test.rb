require 'test/unit'
require './family'

class FamilyTest < Test::Unit::TestCase
  def setup
    @family = Family.new('test')
    @family.add_image('i2.jpg', 'images/i2.jpg', 200, 100)
    @family.add_image('i3.jpg', 'images/i3.jpg', 300, 100)
    @family.add_image('i1.jpg', 'images/i1.jpg', 100, 100)
  end

  def test_adding_new_images_should_resort_by_ratio
    @family.add_image('i4.jpg', 'images/i4.jpg', 50, 100)
    assert(@family.images[0].name == 'i4.jpg') 
    assert(@family.images[1].name == 'i1.jpg')
    assert(@family.images[2].name == 'i2.jpg')
    assert(@family.images[3].name == 'i3.jpg')
  end
end