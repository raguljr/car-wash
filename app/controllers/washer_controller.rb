class WasherController < ApplicationController
  def index
  end

  def list
    @results, @count = Searcher.washer(params[:what], params[:where], params[:page])
    if @count == 1
      redirect_to action: 'info', id:@results.first.try(:id), name:@results.first.try(:name).to_s.gsub(' ','-')
    end
  end

  def info
    @info = Washer.includes(:address,:feature,:working_day).find(params[:id])
    ratings = Comment.where(washer_id: params[:id]).pluck(:rating)
    if ratings.length > 0
      @comments = {
        "ratings": (ratings.sum / ratings.count).to_i,
        "total_ratings": ratings.count
      }
    else
    @comments = {
        "ratings": 0,
        "total_ratings": 0
      }
    end
  end

  def city_page
    @results, @address, @count = Searcher.city(params[:state], params[:name], params[:what], params[:page])
    render 'list'
  end

  def where_autocomplete
    query = params[:term].downcase
    city = Address.where("lower(city) like ?", "#{query}%").or(Address.where("zip like ?", "#{query}%")).limit(10).pluck(:city, :state)
    city = city.map{|info| info[0]+","+info[1]}
    state = Address.where("lower(state) like ?", "#{query}%").limit(10).pluck(:state)
    @results = (city + state).reject{|n| n.nil?}.uniq[0..9]
    render json: @results
  end

  def what_autocomplete
    query = params[:term].downcase
    @results = ["automatic","handwash","touchless","spray","interior","oil change","shampoo","free vacuum"].select{|val| val.include?(query)}
    @results += Washer.where("name like ?", "%#{query}%").limit(10).pluck(:name)
    # @results += Washer.what_autocomplete(query)
    render json: @results
  end
end
