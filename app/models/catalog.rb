class Catalog < ActiveRecord::Base
  attr_accessible :name, :url

  belongs_to :user
  has_many :tasks, :dependent => :destroy
end
