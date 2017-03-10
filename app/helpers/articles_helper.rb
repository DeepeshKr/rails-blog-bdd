module ArticlesHelper
  
  def persisted_comments comments
    comments.reject{ |comment| comment.new_record? }
  end
  
  # def resource_not_found
#     message = "The article you are looking for could not be found"
#     flash[:alert] = message
#     redirect_to root_path
#   end
#
end
