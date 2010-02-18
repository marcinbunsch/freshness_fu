%w[collection subject visit].each do |item|
  require File.join(File.dirname(__FILE__), 'lib', 'freshness_fu', item)
end

ActiveRecord::Base.extend FreshnessFu::Subject

# include freshable collection hooks where applicable
# TODO: change the ugly 'send :include'
ActiveRecord::Associations::AssociationCollection.send :include, FreshnessFu::Collection
Array.send :include, FreshnessFu::Collection
