class Ad < ActiveRecord::Base
  belongs_to :du_ad, :polymorphic => true
  
end
