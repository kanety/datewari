1000.times do |i|
  g = Group.create(name: "group_#{i+1}", created_at: i.days.ago, updated_at: i.days.ago)
  User.create(name: "user_#{i+1}", created_at: i.days.ago, updated_at: i.days.ago, group: g)
end
