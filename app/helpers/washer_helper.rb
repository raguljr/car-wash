module WasherHelper
  def breadcrumb_for_city(state, city)
    crumbs = "<li class='breadcrumb-item'><a href='"+state_url(state)+"'>#{state}</a></li><li class='breadcrumb-item'><a href='"+city_url(city)+"'>#{city}</a></li>"
    crumbs.html_safe
  end

  def city_url(city)
    "/city/#{city.downcase.gsub(' ','-')}"
  end

  def state_url(state)
    "/list?where=#{state.downcase.gsub(' ','-')}"
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

end
