# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
20.times do
  Organization.create!(name: Faker::Company.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip, phone: Faker::PhoneNumber.cell_phone_in_e164)
end



20.times do
  Child.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end

10.times do
  SearchVector.create!(name: Faker::Company.name, in_continuous_search: false)
end

10.times do
  random_child_id = Child.find(Child.pluck(:id).sample).id
  random_search_vector_id = SearchVector.find(SearchVector.pluck(:id).sample).id
  random_user_id = User.find(User.pluck(:id).sample).id
  Finding.create!(child_id: random_child_id, search_vector_id: random_search_vector_id, user_id: random_user_id)
end
# =end
#
#
# 20.times do
#   ava = [
#     "https://vengreso.com/wp-content/uploads/2016/03/LinkedIn-Profile-Professional-Picture-Sample-Bernie-Borges.png",
#     "https://www.himalmag.com/wp-content/uploads/2019/07/sample-profile-picture.png",
#     "https://www.rottmair.de/profiles/Sebastian_Rottmair.jpg",
#     "https://www.beautycastnetwork.com/images/banner-profile_pic.jpg",
#     "https://www.templatebeats.com/files/images/profile_user.jpg",
#     "https://www.renewablecities.ca/rc-wp/wp-content/uploads/Scott-Sinclair.jpg"
#   ].sample
#   User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, phone: Faker::PhoneNumber.cell_phone_in_e164, ava: ava)
# end


=begin
10.times do
  Contact.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end
=end

# 20.times do |i|
#   ava = [
#         "https://vengreso.com/wp-content/uploads/2016/03/LinkedIn-Profile-Professional-Picture-Sample-Bernie-Borges.png",
#         "https://www.himalmag.com/wp-content/uploads/2019/07/sample-profile-picture.png",
#         "https://www.rottmair.de/profiles/Sebastian_Rottmair.jpg",
#         "https://www.beautycastnetwork.com/images/banner-profile_pic.jpg",
#         "https://www.templatebeats.com/files/images/profile_user.jpg",
#         "https://www.renewablecities.ca/rc-wp/wp-content/uploads/Scott-Sinclair.jpg"
#       ].sample
#   user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, phone: Faker::PhoneNumber.cell_phone_in_e164, ava: ava)
#   user.user_organizations.create!(organization_id: i + 1, role: "user")
# end

SchoolDistrict.all.each do |item|
  address = Address.create!(address_1: item.address, lat: item.lat, long: item.long)
  item.update!(address_id: address.id, lat: nil, long: nil, address: nil)
end
