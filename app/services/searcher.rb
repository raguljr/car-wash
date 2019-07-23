class Searcher

  def self.washer(what_query, place_query, page)
    if what_query.to_s.include?(',')
      place_query = what_query.split(",")[1..].join(',')
      what_query = what_query.split(",")[0]
    end
    if place_query.present? && what_query.present?
      place = {}
      if place_query.include?(',')
        place['city'] = place_query.split(',')[0]
        place['state'] = place_query.split(',')[1]
      else
        place['state'] = place_query
      end
      @results = Washer.includes(:address).where(name: what_query).where(addresses: place).page(page).per(10)
      @count = Washer.includes(:address).where(name: what_query).where(addresses: place).count
    elsif place_query.present? || what_query.present?
      where_query = {}
      if place_query.present?
        city,state_code=place_query.split(",")
        if state_code.present?
          washer_ids = Address.where('lower(city) = ?', city.gsub('-',' ').downcase).pluck(:washer_id)
          where_query["id"] = washer_ids
        else
          washer_ids = Address.where('lower(state) = ?', city.gsub('-',' ').downcase).pluck(:washer_id)
          where_query["id"] = washer_ids
        end
      else
        washer_ids = []
      end
      if ["automatic","handwash","touchless","spray","interior","oil change","shampoo","free vacuum"].include?(what_query)
        what_feature = {}
        what_feature[what_query.gsub(" ","_")] = 1
        @count = Washer.joins(:feature,:address).where(features: what_feature).where(where_query).count
        @results = Washer.joins(:feature,:address).where(features: what_feature).where(where_query).page(page).per(10)
      else
        @count = Washer.where("name like ?","#{what_query}%").where(where_query).count
        @results = Washer.where("name like ?","#{what_query}%").where(where_query).page(page).per(10)
      end
    else
      @count = 0
      @results = Kaminari.paginate_array([]).page(0).per(10)
    end
    [@results, @count]
  end

  def self.city(state, city, what, page)
    if what.present?
      what_feature = {}
      what_feature[what.to_s.gsub(" ","_")] = 1 
      @count = Washer.joins(:feature,:address).where('lower(city) = ? and lower(state) = ?', city.gsub('-',' ').downcase, state.gsub('-',' ').downcase).where(features: what_feature).count
      @results = Washer.joins(:feature,:address).where('lower(city) = ? and lower(state) = ?', city.gsub('-',' ').downcase, state.gsub('-',' ').downcase).where(features: what_feature).page(page).per(10)
      @address = Address.where('lower(city) = ? and lower(state) = ?', city.gsub('-',' ').downcase, state.gsub('-',' ').downcase).try(:first)
    else
      @count = Washer.joins(:feature,:address).where('lower(city) = ? and lower(state) = ?', city.gsub('-',' ').downcase, state.gsub('-',' ').downcase).count
      @results = Washer.joins(:feature,:address).where('lower(city) = ? and lower(state) = ?', city.gsub('-',' ').downcase, state.gsub('-',' ').downcase).page(page).per(10)
      @address = Address.where('lower(city) = ? and lower(state) = ?', city.gsub('-',' ').downcase, state.gsub('-',' ').downcase).try(:first)
    end
    [@results, @address, @count]
  end

end