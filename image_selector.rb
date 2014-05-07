class ImageSelector
  def select(family, width, height)
    unless family then return nil end

    target_rating = (width * height) / (width.to_f / height)
    match = nil
    family.images.each do |image|
      if image.width == width and image.height == height
        return image
      elsif image.width < width or image.height < height
        next
      elsif is_better_match(target_rating, match, image)
        match = image
      end
    end
    return match
  end

  private
  # return true if 'image' is a closer match to the desired width
  # and height, false if 'current_match' is a closer match.
  def is_better_match(target_rating, current_match, image)
    if image.match_rating < target_rating
      return false
    elsif current_match == nil or image.match_rating < current_match.match_rating
      return true
    elsif image.match_rating == current_match.match_rating
      return image.ratio < current_match.ratio
    end
    return false
  end
end