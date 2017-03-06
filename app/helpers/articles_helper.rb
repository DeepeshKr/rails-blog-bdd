module ArticlesHelper
  
  def resource_not_found
    message = "The article you are looking for could not be found" 
    flash[:alert] = message
    redirect_to root_path
  end
end
