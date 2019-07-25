class CommentController < ApplicationController
  def save
    comment = Comment.new(comment_params)
    if comment.save
      message = "Your comment is added and will be visible once approved."
    else
      message = "Sorry, you have already rated this service provider"
    end
    render :json => {"message": message}
  end

  def fetch_comments
    result = []
    comments = Comment.select(:id,:name,:rating,:comment,:title).approved.where(washer_id: params[:washer_id]).order("id desc").offset(params[:offset]).limit(2)
    comments.each do |comment|
      images = {"images": comment.images.map{|i| url_for(i)  }}.as_json
      result << comment.as_json.merge(images)
    end
    render :json => {"results": result}
  end

  private
  def comment_params
    params.permit(:rating, :name, :email, :comment, :washer_id, :title, images: []).merge({"ip_address": request.remote_ip})
  end

end
