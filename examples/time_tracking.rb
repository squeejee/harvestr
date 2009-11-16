require 'lib/harvestr'
Harvest.domain = 'yourdomain'
Harvest.email = 'you@example.com'
Harvest.password = 'yourpass'
client = Harvest::TimeTracking.new

# add a new entry
client.add({:project_id => 408960, :task_id => 333866, :notes => 'Writing TPS reports', :hours => 1.21})
#=> <Mash client="Pengwynn Group" hours=1.21 id=14319479 notes="Writing TPS reports" project="Internal" project_id="408960" task="Project Management" task_id="333866">

# toggle an entry
client.toggle(14319479)
#=> <Mash client="Pengwynn Group" hours=1.21 id=14319479 notes="Writing TPS reports" project="Internal" project_id="408960" task="Project Management" task_id="333866" timer_started_at=Sat Aug 01 19:14:07 UTC 2009>
