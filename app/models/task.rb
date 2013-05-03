class Task < ActiveRecord::Base
  attr_accessible :name, :object, :text, :url
  belongs_to :catalog
end
