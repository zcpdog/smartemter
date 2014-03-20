#encoding utf-8
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
    file.close
    %x[/ASR/demo/DO.ror]
    begin
      Encoding.default_external = Encoding::UTF_8
      Encoding.default_internal = Encoding::UTF_8
      output_file = File.open("#{@audio.asset_file_name}.lab")
      @words = output_file.read
      @words.gsub!(/\s+/," ")
      @words.gsub!(/\d+/,"")
      @search = Sunspot.search(Sentence) do
        fulltext @words.gsub(/\s+/,"")
      end
      @sentences = @search.results
    rescue Exception => e
      puts "#{e.inspect}"
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
