module Harvest
  class Reports < Harvest::Base
    # GET /projects
    def projects
      Mash.new(self.class.get("/projects")).projects
    end
    
    # GET /projects/#{project_id}/entries?from=YYYYMMDD&to=YYYYMMDD
    def project_entries(project_id, from, to, user_id=nil)
      opts = {:from => from, :to => to}
      opts[:user_id] = user_id if user_id
      Mash.new(self.class.get("/projects/#{project_id}/entries", :query => opts)).day_entries
    end
    
    def total_project_hours(project_id, from, to, user_id=nil)
      pe = project_entries(project_id, from, to, user_id)
      total = 0.0
      if pe
        pe.each {|msh| total += msh.hours}
      end
      total
    end
    
    # [['proj1', 25.5], ['proj2', 33.3]]
    def project_totals(from=7.days.ago, to=Date.today)
      @pt = []
      projects.each do |p|
        hrs = total_project_hours(p.id, from, to)
        @pt << [p.name, hrs] if hrs > 0
      end
      @pt
    end
  end
end