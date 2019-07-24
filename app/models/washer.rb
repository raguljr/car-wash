class Washer < ApplicationRecord
  has_one :address, :dependent => :destroy
  has_one :feature, :dependent => :destroy
  has_one :working_day, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  def self.what_autocomplete(query)
    result = joins(:address).where("name like ?", "%#{query}%").select("address.city,address.state,address.state_code,name").limit(10).pluck(:name,:city,:state,:state_code)
    result.map{|x| x[0..2].reject{|a| a == ""  }.join(',')}
  end

end
