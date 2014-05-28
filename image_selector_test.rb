require 'test/unit'
require './family'
require './image'
require './image_selector'

class ImageSelectorTest < Test::Unit::TestCase
  def setup
    @selector = ImageSelector.new
  end

  def test_select_should_return_nil_when_the_family_has_no_images
    family = Family.new('test')
    actual = @selector.select(family, 100, 100)
    assert_nil(actual)
  end

  def test_select_should_return_nil_when_there_are_only_images_with_smaller_dimensions
    family = Family.new('test')
    family.add_image(Image.new('i1.jpg', 'images/i1.jpg', 299, 99))
    family.add_image(Image.new('i2.jpg', 'images/i2.jpg', 300, 99))
    family.add_image(Image.new('i3.jpg', 'images/i3.jpg', 299, 100))
    actual = @selector.select(family, 300, 100)
    assert_nil(actual)
  end

  def test_select_should_return_an_exact_match_if_one_exists
    family = Family.new('test')
    family.add_image(Image.new('i1.jpg', 'images/i1.jpg', 400, 250))
    actual = @selector.select(family, 400, 250)
    assert_equal('i1.jpg', actual.name)
  end

  def test_select_should_return_a_larger_image_closest_in_size_to_the_requested_dimensions
    family = Family.new('test')
    family.add_image(Image.new('i1.jpg', 'images/i1.jpg', 600, 400))
    family.add_image(Image.new('i2.jpg', 'images/i2.jpg', 450, 300))
    family.add_image(Image.new('i3.jpg', 'images/i3.jpg', 500, 200))
    family.add_image(Image.new('i4.jpg', 'images/i4.jpg', 450, 200)) # should be this one
    actual = @selector.select(family, 300, 200)
    assert_equal('i4.jpg', actual.name)
  end
end