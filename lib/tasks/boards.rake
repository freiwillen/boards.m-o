namespace :boards do
  task :photos_to_paperclip => :environment do
  	c = 0
    Board.all.each do |board|
      
      if board.has_old_photo?  
        
        board.photo = File.new(board.old_photo_path) and board.save if board.has_old_photo?  
    	else
    	c += 1	
    	puts board.old_photo_path if board.old_photo_path.include?('А')
  	  end
    end
    puts c
  end

  task :strip_data => :environment do
    Board.all.each do |board|
      board.update_attributes :price => board.price.to_s.strip, 
							:code => board.code.to_s.strip, 
							:side => board.side.to_s.strip, 
							:size => board.size.to_s.strip, 
							:construction_type => board.construction_type.to_s.strip, 
							:city => board.city.to_s.strip, 
							:direction => board.direction.to_s.strip, 
							:district => board.direction.to_s.strip, 
							:address => board.address.to_s.gsub('вул.','').gsub('Вул.','').gsub('Eл.','').gsub('ул.','').strip
    end
    Point.all.each do |point|
      point.update_attributes :address => point.address.to_s.gsub('вул.','').gsub('Вул.','').gsub('Eл.','').gsub('ул.','').strip
    end
    
  end
  task :retie_photos_to_boards => :environment do
	puts FileUtils.pwd
	(Dir.entries('public/system/photos') - %w{. ..}).each do |entry|
	  puts '='*20
	  puts "id: #{entry}"
	  path = "public/system/photos/"
	  file_name = (Dir.entries(path + '/' + entry + '/original') - %w{. ..}).first
	  puts "file: #{file_name}"
	  Board.find(entry).update_attribute :photo_file_name, file_name
	  Board.find(entry).update_attribute :photo_content_type, 'image/jpeg'
	end
  end
end
