class SentencesController < ApplicationController
  def search
    @keyword = params[:q]
    @search = Sunspot.search(Sentence) do
      fulltext params[:q]
    end
    @sentences = @search.results
    render :index
  end
  
  def index
    
  end
end