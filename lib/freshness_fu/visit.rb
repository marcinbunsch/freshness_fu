module FreshnessFu
  
  class Visit < ActiveRecord::Base
    set_table_name "freshness_fu_visits"
    belongs_to :actor, :polymorphic => true
    belongs_to :subject, :polymorphic => true
  end
  
end