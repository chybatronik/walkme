class Publication < ActiveRecord::Base
  attr_accessible :catalog_id, :url, :user_id
  belongs_to :catalog
  belongs_to :user
end
