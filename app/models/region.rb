class Region < ReferencePoint
  default_scope order('name')
  #has_many :reference_points, :foreign_key => 'parent_id', :class_name => 'ReferencePoint'
  has_many :cities, :foreign_key => 'parent_id', :class_name => 'City', :order => '`name`'
  has_many :points, :foreign_key => 'reference_point_id', :order => '`address`'
  
  def reference_points
    ReferencePoint.all(:conditions => {:parent_id => self.id}, :order => '`name`') - self.cities
  end
  
  def reference_points_all
    (self.cities.map{|city| city.reference_points}.flatten + self.reference_points).uniq
  end
  
  #def points
  #  Point.find_all_by_reference_point_id(id)# + cities.map(&:points).flatten
  #end
end
