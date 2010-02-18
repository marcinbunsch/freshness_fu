module FreshnessFu

  module Collection
  
    # Freshen the collection by marking fresh items and defreshem them for future use
    #
    # Use this in conjunction with #defreshen
    def freshen(actor, opts = { :defresh => false })
      return [] if size == 0
      return @freshened if @freshened
      subject_klass = first.class.to_s
      subject_ids = collect { |item| item.id }
      # use one query per collection      
      visited_ids = FreshnessFu::Visit.find(:all, :select => 'subject_id', :conditions => ['subject_id IN (?) AND subject_type = ?', subject_ids, subject_klass]).collect { |v| v.subject_id }
      @freshened = collect do |item|
        if !visited_ids.include?(item.id) and item.respond_to?(:fresh!)
          item.defresh_for(actor) unless opts[:defresh] === false
          item.fresh!  
        end
        item
      end
    end
  
    # Freshen the collection by marking fresh items and defreshes them for future use
    #
    # Use this if you want to defresh the collection right after use
    def freshen!(actor, opts = {})
      freshen(actor, opts.merge({ :defresh => true }))
    end
  
    # Defreshen all items in the collection
    #
    # If you want to defresh the collection by yourself, call this
    def defreshen(actor)
      each { |item| item.defresh_for(actor) if item.respond_to?(:defresh_for) and !item.fresh_visit }
      true
    end
  
  end
  
end
