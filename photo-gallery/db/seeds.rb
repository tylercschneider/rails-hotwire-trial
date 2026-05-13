require "csv"

CSV.foreach(Rails.root.join("db/photos.csv"), headers: true) do |row|
  Photo.find_or_create_by!(source_url: row["url"]) do |photo|
    photo.photographer = row["photographer"]
    photo.src_medium = row["src.medium"]
    photo.alt = row["alt"]
  end
end
