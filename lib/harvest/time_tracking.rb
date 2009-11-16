module Harvest
  class TimeTracking < Harvest::Base

    # GET /daily
    # GET /daily/#{day_of_the_year}/#{year}
    def daily(date=nil)
      date = DateTime.parse(date) if date.is_a?(String)
      if date.respond_to?(:yday)
        response = self.class.get("/daily/#{date.yday}/#{date.year}")
      else
        response = self.class.get('/daily')
      end
      response
    end
    
    # GET /daily/show/#{day_entry_id}
    def entry(id)
      Mash.new(self.class.get("/daily/show/#{id}")).add.day_entry
    end
    
    # GET /daily/timer/#{day_entry_id}
    def toggle(id)
      Mash.new(self.class.get("/daily/timer/#{id}")).timer.day_entry
    end
    
    # POST /daily/add
    def add(body)
      Mash.new(self.class.post("/daily/add", :body => body)).add.day_entry
    end
    
    # DELETE /daily/delete/#{day_entry_id}
    def delete(id)
      Mash.new(self.class.delete("/daily/delete/#{id}"))
    end
    
    # POST /daily/update/#{day_entry_id}
    def update(id, body)
      # current_entry = entry(id)
      # body = current_entry.merge(Mash.new body.to_hash)
      # puts body.inspect
      Mash.new(self.class.post("/daily/update/#{id}", :body => body)).add.day_entry
    end
  end
end