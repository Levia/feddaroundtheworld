module ApplicationHelper
  PLACES =
    [
      "bologna", "brighton", "bristol", "cambridge", "dublin", "edinburgh", "bath",
      "nottingham", "bedford", "locri", "london", "lyon", "madrid", "opatija", "oxford", "rijeka",
      "geneva", "liverpool", "cardiff", "turin", "malaga"
    ]
  def images_paths
    images_hash = {}
    PLACES.each do |place|
      images_hash.merge!({"#{place}": image_url("#{place}.jpg")})
    end
    images_hash
  end
end
