class CreateFreshnessFuVisits < ActiveRecord::Migration
  def self.up
    create_table :freshness_fu_visits do |t|
      t.references :actor, :polymorphic => true
      t.references :subject, :polymorphic => true
    end
  end

  def self.down
    drop_table :freshness_fu_visits
  end
end