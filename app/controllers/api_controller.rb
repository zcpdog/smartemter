class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:upload]
  def new
  end
  
  def upload
    uploaded_io = params[:filePath]
    File.new(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    render :show
  end
  
  def show
    
  end
end
