class WasherController < ApplicationController
  def index
  end

  def list
    @results, @count = Searcher.washer(params[:what], params[:city], params[:page])
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
    @results += Washer.where("name like ?", "%#{query}%").limit(10).pluck(:name)
    render json: @results
  end
end
