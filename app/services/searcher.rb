class Searcher

  def self.washer(what_query, place_query, page)
    if what_query.include?(',')
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
        obj = {}
        city,state_code=place_query.split(",")
        if state_code.present?
          obj["city"] = city
          washer_ids = Address.where(obj).pluck(:washer_id)
          where_query["id"] = washer_ids
        else
          obj["state"] = city
          washer_ids = Address.where(obj).pluck(:washer_id)
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

  def self.city(city, page)
    @count = Washer.joins(:feature,:address).where('lower(city) = ?', city.gsub('-',' ').downcase).count
    @results = Washer.joins(:feature,:address).where('lower(city) = ?', city.gsub('-',' ').downcase).page(page).per(10)
    [@results, @count]
  end

end