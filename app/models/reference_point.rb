class ReferencePoint < ActiveRecord::Base
  has_many :points, :order => '`address`'
  #belongs_to :parent, :class_name => 'ReferencePoint'
  scope :untied, where('parent_id is null and type <> "Region"').order('name')

  has_attached_file :icon
  
  def old_icon=(p)
    unless p.blank? or self.id == nil
      path = c_dir+"#{self.id}.jpg"
      FileUtils.rm path if File.exist? path
      File.open(path,'wb'){|f|f.write(p.read)}
    end
  end
  
  def old_icon
    if self.id and File.exist?(c_dir+"#{self.id}.jpg")
      "#{ph_dir}#{self.id}.jpg"
    else
      false
    end
  end
  
  def has_old_icon?
    File.exist?(old_icon_path)
  end

  def old_icon_path
    c_dir+"#{self.id}.jpg"
  end

  def address
    read_attribute(:address).to_s
  end
  
  def before_destroy
    path = c_dir+"#{self.id}.jpg"
    FileUtils.rm path if File.exist? path
  end
  
  def city?
    read_attribute(:type) == 'City'
  end
  
  def tp=(p)
=begin
    if p == 'district'
      self[:city] = false
      self[:district] = true
    elsif  p == 'city'
      self[:city] = true
      self[:district] = false
    else
      self[:city] = false
      self[:district] = false
    end
    
    self.save
=end
    
    self.type = if p == 'region'
      self.parent_id = nil
      'Region'
    elsif  p == 'city'
      'City'
    else
      'ReferencePoint'
    end
    self.save
    
    #raise self.inspect
  end
  
  def tp
    if self.type == 'City'
      return 'city'
    elsif self.type == 'Region'
      return 'region'
    else
      return 'reference_point' 
    end
  end
  
  def parent
    ReferencePoint.find(self.parent_id) if self.parent_id
  end
  
  def parent_id=(p)
    unless p.blank? or p.to_i == self.id
      p = ReferencePoint.find p
      t1,t2 = 0,0
      t1 = 1 if self.type.to_s == 'City'
      t1 = 2 if self.type.to_s == 'Region'
      t2 = 1 if p.type.to_s == 'City'
      t2 = 2 if p.type.to_s == 'Region'
	#raise p.type.to_s.inspect
	#raise (t2.to_s+' '+t1.to_s).inspect
      self[:parent_id] = p.id and save if t2 > t1
    end
  end
  
  def coords
    "#{coord_x},#{coord_y}"
  end
  
  def coords=(p)
    p = (p.blank? ? '0,0' : p).split(',')
    update_attribute :coord_x, p[0]
    update_attribute :coord_y, p[1]
  end

private

  def c_dir
    "#{$pth}public/images/reference_points/rp"
  end
  
  def ph_dir
    c_dir.gsub('public/','')
  end
  
end
