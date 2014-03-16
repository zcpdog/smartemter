class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:upload]
  def new
  end
  
  def upload
    @audio = Audio.new(asset: params[:filePath])
    @audio.save
    render :show
  end
  
  def show
    
  end
end
