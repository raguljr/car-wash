class WasherController < ApplicationController
  def index
  end

  def list
    @results, @count = Searcher.washer(params[:what], params[:city], params[:page])
    if @count == 1
      redirect_to action: 'info', id:@results.first.try(:id), name:@results.first.try(:name).to_s.gsub(' ','-')
    end
  end

  def info
    @info = Washer.includes(:address,:feature,:working_day).find(params[:id])
  end

  def city_page
    @results, @count = Searcher.city(params[:name], params[:page])
    render 'list'
  end

  def where_autocomplete
    query = params[:term].downcase
    city = Address.where("lower(city) like ?", "#{query}%").or(Address.where("zip like ?", "#{query}%")).limit(10).pluck(:city, :state_code)
    city = city.map{|info| info[0]+","+info[1]}
    state = Address.where("lower(state) like ?", "#{query}%").limit(10).pluck(:state)
    @results = (city + state).reject{|n| n.nil?}.uniq[0..9]
    render json: @results
  end

  def what_autocomplete
    query = params[:term].downcase
    @results = ["automatic","handwash","touchless","spray","interior","oil change","shampoo","free vacuum"].select{|val| val.include?(query)}
    # @results += Washer.where("name like ?", "%#{query}%").limit(10).pluck(:name)
    @results += Washer.what_autocomplete(query)
    render json: @results
  end
end
