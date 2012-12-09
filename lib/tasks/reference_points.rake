namespace :reference_points do
  task :icons_to_paperclip => :environment do
    ReferencePoint.all.each do |reference_point|
      puts reference_point.old_icon_path
      puts reference_point.has_old_icon?.to_s
      reference_point.icon = File.new(reference_point.old_icon_path) and reference_point.save if reference_point.has_old_icon?  
    end
  end
end
