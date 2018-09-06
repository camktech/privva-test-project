User.destroy_all
Issue.destroy_all

10.times do 
  name = Faker::Name.name
  User.create(name: name, email: Faker::Internet.email(name))
end

25.times do
  users = User.find(User.pluck(:id).sample(2))
  Issue.create(summary: Faker::Lorem.sentence, status: Issue::STATUSES.sample, reporter_id: users[0].id, assignee_id: users[1].id)
end