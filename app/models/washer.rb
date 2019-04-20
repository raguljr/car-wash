class Washer < ApplicationRecord
  has_one :address
  has_one :feature
  has_one :working_day
end
