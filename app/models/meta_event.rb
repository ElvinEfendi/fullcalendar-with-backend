class MetaEvent < ActiveRecord::Base
  validates_presence_of :starts_at, :ends_at

end
