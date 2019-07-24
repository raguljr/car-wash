module WasherHelper
  def breadcrumb_for_city(state, city)
    crumbs = "<li class='breadcrumb-item'><a href='"+state_url(state)+"'>#{state}</a></li><li class='breadcrumb-item'><a href='"+city_url(state, city)+"'>#{city}</a></li>"
    crumbs.html_safe
  end

  def city_url(state, city)
    "#{state_url(state)}/#{city.downcase.gsub(' ','-')}"
  end

  def state_url(state)
    "/#{state.downcase.gsub(' ','-')}"
  end

  def business_url(result)
    id = result.id
    name = result.name.squish.downcase.gsub(" ","-")
    state = result.address.state.squish.downcase.gsub(" ","-")
    city = result.address.city.squish.downcase.gsub(" ","-")
    "/#{state}/#{city}/#{name}/#{id}"
  end

  def form_stars(rating)
    rating_data = ""
    rating.times  do
      rating_data += '<i class="fas fa-star"></i>'
    end
    (5-rating).times  do
      rating_data += '<i class="far fa-star"></i>'
    end
    rating_data.html_safe
  end

  def rating_helper(comments)
    if comments.count > 0
      [(comments.try(:sum,:rating) / comments.count).to_i, comments.count]
    else
      [0,0]
    end
  end

end
