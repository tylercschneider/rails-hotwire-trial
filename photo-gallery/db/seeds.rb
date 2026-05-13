require "csv"

User.find_or_create_by!(email_address: "admin@example.com") do |user|
  user.password = "password"
end

viewer_emails = %w[ alice@example.com bob@example.com carol@example.com ]
viewer_emails.each do |email|
  User.find_or_create_by!(email_address: email) do |user|
    user.password = "password"
  end
end

CSV.foreach(Rails.root.join("db/photos.csv"), headers: true) do |row|
  Photo.find_or_create_by!(source_url: row["url"]) do |photo|
    photo.photographer = row["photographer"]
    photo.src_medium = row["src.medium"]
    photo.alt = row["alt"]
  end
end

photos = Photo.order(:id).to_a
viewer_emails.each_with_index do |email, i|
  user = User.find_by!(email_address: email)
  photos.first(i + 2).each do |photo|
    Like.find_or_create_by!(user: user, photo: photo)
  end
end
