class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:upload]
  def new
  end
  
  def upload
    @audio = Audio.new(asset: params[:filePath])
    @audio.save
    data_file = "/ASR/demo/ror.scp"
    file = File.open(File.expand_path(data_file), 'w')
    file.write("#{@audio.asset_file_name} sox #{@audio.asset.path} -t wav -r 8000 - |")
    logger.info %x[/ASR/demo/DO.ror]
    file.close if file.present?
      
    begin
      output_file = File.open("#{@audio.asset_file_name}.lab","r:UTF-8")
      @words = output_file.read
      logger.info "=============#{@words}==========="
      @words.gsub!(/\s+/," ")
      @words.gsub!(/\d+/,"")
      logger.info "=============#{@words}==========="
      @search = Sunspot.search(Sentence) do
        fulltext @words.gsub(/\s+/,"")
      end
      @sentences = @search.results
    rescue Exception => e
      logger.info "#{e.inspect}"
    ensure
      output_file.close unless output_file.nil?
    end
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def show
    
  end
end
