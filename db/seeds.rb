# Constants
PWD = "123456789"


# Cities
mel = City.create!(name: 'Melbourne')
syd = City.create!(name: 'Sydney')

# Users
# - Clients
(1..10).each do |num|
  u = User.create!(email: "client#{num}@e.com", password: PWD, password_confirmation: PWD)
  Client.create!(name: "Client#{num}", user: u)
end

# - Drivers
(1..10).each do |num|
  u = User.create!(email: "driver#{num}@e.com", password: PWD, password_confirmation: PWD)
  Driver.create!(name: "Driver#{num}", user: u)
end

# - Staff members
# -- city analyst
user_mel_ca = User.create!(email: "mel_ca@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_mel_ca)
user_syd_ca = User.create!(email: "syd_ca@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_syd_ca)

# -- city managers
user_mel_cm = User.create!(email: "mel_cm@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_mel_cm)
user_syd_cm = User.create!(email: "syd_cm@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_syd_cm)

# -- general managers
user_gm = User.create!(email: "gm@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_gm)

# -- Authorization Admins
user_aa = User.create!(email: "aa@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_aa)

# -- Mixed profiles
user_mel_ca_syd_cm = User.create!(email: "mel_ca_syd_cm@e.com", password: PWD, password_confirmation: PWD)
StaffMember.create!(name: Faker::StarWars.character, user: user_mel_ca_syd_cm)

# Services
City.all.each do |city|
  client_ids = Client.all.pluck(:id).shuffle
  driver_ids = Driver.all.pluck(:id).shuffle
  client_ids.each_with_index do |client_id, i|
    driver_id = driver_ids[i]
    Service.create!(client_id: client_id,
                    driver_id: driver_id,
                    city: city,
                    pickup_address: Faker::Address.street_address,
                    drop_off_address: Faker::Address.street_address)
  end
end

Service.first.accept
Service.second.cancel
s = Service.third
s.accept
s.finish