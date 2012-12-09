class Point < ActiveRecord::Base
  default_scope order('address')
  belongs_to :reference_point
  has_many :boards, :dependent => :destroy#, :foreign_key => 'address'
  scope :untied, where('reference_point_id is null')
  def district
    ReferencePoint.find self.reference_point_id
  end
  
  def reference_point
    ReferencePoint.find self.reference_point_id
  end
  
  def neighbours
    Point.find(:all, :conditions => ["reference_point_id = #{self.reference_point_id} and id != #{self.id}"], :include => :boards)
  end
  
  def city
    reference_point.instance_of?(City) ? reference_point : ''
  end
  
  def region
    reference_point.instance_of?(City) ? reference_point.region : ''
  end
  
  def coords
    "#{read_attribute :coord_x},#{read_attribute :coord_y}"
  end
  
  def coords=(p)
    p = (p.blank? ? '0,0' : p).split(',')
    update_attribute :coord_x, p[0]
    update_attribute :coord_y, p[1]
  end
  
  def nearest_reference_points
    rp = reference_point
    result = [rp]+rp.reference_points
    [0.00005, 0.0001, 0.0005, 0.001, 0.005, 0.01, 0.05, 0.1].each do |radius|
      break if result.any?
      result = reference_points_in_radius(radius)
    end
    #raise result.inspect
    result
  end
  
  def self.find_or_create options
    Point.find(:first, :conditions => options) || Point.create(options)
  end

private
  def reference_points_in_radius(p)
    #0.000005
    lx, rx = coord_x-p, coord_x+p
    by, ty = coord_y-p, coord_y+p
    ReferencePoint.all :conditions => ["coord_x > #{lx} and coord_x < #{rx} and coord_y > #{by} and coord_y < #{ty}"]
  end
end
