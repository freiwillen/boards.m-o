class City < ReferencePoint
  belongs_to :region, :foreign_key => 'parent_id'
  has_many :reference_points, :foreign_key => 'parent_id', :order => '`address`'
  has_many :points, :foreign_key => 'reference_point_id', :order => '`address`'
  alias :rel_region :region
  
  def region
    rel_region || Region.new
  end
end