module ApplicationHelper
  PLACES =
    [
      "bologna", "brighton", "bristol", "cambridge", "dublin", "edinburgh", "bath",
      "locri", "london", "lyon", "madrid", "opatija", "oxford", "rijeka"
    ]
  def images_paths
    images_hash = {}
    PLACES.each do |place|
      images_hash.merge!({"#{place}": image_url("#{place}.jpg")})
    end
    images_hash
  end
end
