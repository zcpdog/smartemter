namespace :bible do
  desc "read bible"
  task :read => :environment do
    File.open('bible-utf8.txt', 'r') do |f1|  
      while line = f1.readline
        if line =~ /(\w+)\s+(\d+):(\d+)\s+([\w\P{ASCII}\s+]+)/ 
          puts "#{$1}-#{$2}-#{$3}-#{$4}"
          sentence = Sentence.create(name: $1,chapter: $2,verse: $3, content: $4)
        end
      end  
    end  
  end
end