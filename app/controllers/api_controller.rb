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
      output_file = File.open("#{@audio.asset_file_name}.lab")
      @words = output_file.read
      @words.gsub!(/\s+/," ")
      @words.gsub!(/\d+/,"")
    rescue Exception => e
      puts "#{e.inspect}"
    ensure
      output_file.close unless output_file.nil?
    end
    
    render :show
  end
  
  def show
    
  end
end
