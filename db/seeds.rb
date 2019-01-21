# Run Authz seed script
require 'rake'
Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
Rails.application.load_tasks
Rake::Task['authz:seed_admin'].invoke

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


# Controller Actions
Authz::ControllerAction.main_app_reachable_controller_actions.each do |controller, actions|
  actions.each do |action|
    Authz::ControllerAction.create!(
      controller: controller,
      action: action)
  end
end


# Business Processes
# - Clients
list_client_profiles = Authz::BusinessProcess.create!(name: 'List client profiles', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'clients', action: %w(index show))
list_client_profiles.controller_actions << cas

update_client_profiles = Authz::BusinessProcess.create!(name: 'Update client profiles', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'clients', action: %w(show edit update))
update_client_profiles.controller_actions << cas

# - Services
request_services = Authz::BusinessProcess.create!(name: 'Request services', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'services', action: %w(new create))
request_services.controller_actions << cas

list_services = Authz::BusinessProcess.create!(name: 'List services', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'services', action: %w(index))
list_services.controller_actions << cas

client_cancel_service = Authz::BusinessProcess.create!(name: 'Client cancel service', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'services', action: %w(client_cancel))
client_cancel_service.controller_actions << cas

driver_accept_service = Authz::BusinessProcess.create!(name: 'Driver accept service', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'services', action: %w(driver_accept))
driver_accept_service.controller_actions << cas

driver_reject_service = Authz::BusinessProcess.create!(name: 'Driver reject service', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'services', action: %w(driver_reject))
driver_reject_service.controller_actions << cas

driver_finish_service = Authz::BusinessProcess.create!(name: 'Driver finish service', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'services', action: %w(driver_finish))
driver_finish_service.controller_actions << cas

# - Drivers
list_driver_profiles = Authz::BusinessProcess.create!(name: 'List driver profiles', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'drivers', action: %w(index show))
list_driver_profiles.controller_actions << cas

update_driver_profiles = Authz::BusinessProcess.create!(name: 'Update driver profiles', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'drivers', action: %w(show edit update))
update_driver_profiles.controller_actions << cas

# - Cities
manage_cities = Authz::BusinessProcess.create!(name: 'Manage Cities', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'cities')
manage_cities.controller_actions << cas

# - Staff
manage_staff = Authz::BusinessProcess.create!(name: 'Manage Staff', description: 'desc')
cas = Authz::ControllerAction.where(controller: 'staff_members')
manage_staff.controller_actions << cas

# - Authz
manage_authorization = Authz::BusinessProcess.find_by!(code: 'manage_authorization')


# Roles
client = Authz::Role.create!(name: 'Client', description: 'desc')
client.business_processes << [update_client_profiles, request_services, list_services, client_cancel_service]

driver = Authz::Role.create!(name: 'Driver', description: 'desc')
driver.business_processes << [list_services, driver_accept_service, driver_reject_service, driver_finish_service, update_driver_profiles]

mel_city_analyst = Authz::Role.create!(name: 'Melbourne City Analyst', description: 'desc')
mel_city_analyst.business_processes << [list_client_profiles, list_services, driver_reject_service, driver_finish_service, list_driver_profiles]

syd_city_analyst = Authz::Role.create!(name: 'Sydney City Analyst', description: 'desc')
syd_city_analyst.business_processes << [list_client_profiles, list_services, driver_reject_service, driver_finish_service, list_driver_profiles]

mel_city_manager = Authz::Role.create!(name: 'Melbourne City Manager', description: 'desc')
mel_city_manager.business_processes << [list_client_profiles, update_client_profiles, list_services, client_cancel_service, driver_reject_service, driver_finish_service, list_driver_profiles, update_driver_profiles]

syd_city_manager = Authz::Role.create!(name: 'Sydney City Manager', description: 'desc')
syd_city_manager.business_processes << [list_client_profiles, update_client_profiles, list_services, client_cancel_service, driver_reject_service, driver_finish_service, list_driver_profiles, update_driver_profiles]

general_manager = Authz::Role.create!(name: 'General Manager', description: 'desc')
general_manager.business_processes << [list_client_profiles, update_client_profiles, list_services, client_cancel_service, driver_reject_service, driver_finish_service, list_driver_profiles, update_driver_profiles, manage_cities]

auth_admin = Authz::Role.create!(name: 'Authorization Administrator', description: 'desc')
auth_admin.business_processes << [manage_staff, manage_authorization]


# Scoping Rules
sbcl = 'ScopableByClient'
sbdr = 'ScopableByDriver'
sbci = 'ScopableByCity'

# - Client
Authz::ScopingRule.create!(role: client, scopable: sbcl, keyword: 'Mine')
Authz::ScopingRule.create!(role: client, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: client, scopable: sbci, keyword: 'All')

# - Driver
Authz::ScopingRule.create!(role: driver, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: driver, scopable: sbdr, keyword: 'Mine')
Authz::ScopingRule.create!(role: driver, scopable: sbci, keyword: 'All')

# - City Analysts (Mel and Syd)
Authz::ScopingRule.create!(role: mel_city_analyst, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: mel_city_analyst, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: mel_city_analyst, scopable: sbci, keyword: mel.name)

Authz::ScopingRule.create!(role: syd_city_analyst, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: syd_city_analyst, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: syd_city_analyst, scopable: sbci, keyword: syd.name)

# - City Managers (Mel and Syd)
Authz::ScopingRule.create!(role: mel_city_manager, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: mel_city_manager, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: mel_city_manager, scopable: sbci, keyword: mel.name)

Authz::ScopingRule.create!(role: syd_city_manager, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: syd_city_manager, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: syd_city_manager, scopable: sbci, keyword: syd.name)

# - General Manager
Authz::ScopingRule.create!(role: general_manager, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: general_manager, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: general_manager, scopable: sbci, keyword: 'All')

# - Authorization Admin
Authz::ScopingRule.create!(role: auth_admin, scopable: sbcl, keyword: 'All')
Authz::ScopingRule.create!(role: auth_admin, scopable: sbdr, keyword: 'All')
Authz::ScopingRule.create!(role: auth_admin, scopable: sbci, keyword: 'All')


# Grant roles to users
# - Clients
User.where('LOWER(email) LIKE ?', 'client%').each { |u| u.roles << [client] }

# - Drivers
User.where('LOWER(email) LIKE ?', 'driver%').each { |u| u.roles << [driver] }

# - City Analysts
user_mel_ca.roles << [mel_city_analyst]
user_syd_ca.roles << [syd_city_analyst]

# - City Managers
user_mel_cm.roles << [mel_city_manager]
user_syd_cm.roles << [syd_city_manager]

# - General Manager
user_gm.roles << [general_manager]

# - Auth Admin
user_aa.roles << [auth_admin]

# - Mixed Profiles: Melbourne City Analyst + Sydney City Manager
user_mel_ca_syd_cm.roles << [mel_city_analyst, syd_city_manager]