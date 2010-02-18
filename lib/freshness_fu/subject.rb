module FreshnessFu

  module Subject

    def self.extended(base)
      base.extend ClassMethods
    end

    module ClassMethods
    
      # Install fresh 
      def freshable(*args)
        attr_accessor :is_fresh
        include InstanceMethods
        has_one :fresh_visit, :class_name => 'FreshnessFu::Visit', :as => :subject
      end

    end
  
    module InstanceMethods
    
      # defresh subject for supplied actor
      def defresh_for(actor)
        create_fresh_visit(:actor => actor)
      end
    
      # set subject to fresh
      def fresh!
        self.is_fresh= true
      end
    
      # check whether subject is fresh
      def fresh?
        self.is_fresh == true
      end
    
    end
    
  end

end

