require 'faker'

start_time = Time.now.beginning_of_day
end_time = Time.now.end_of_day

while start_time <= end_time
  2.upto(6) do |i|
    Metric.create!(
      name: Faker::Name.unique.name,
      value: rand(1.0..100.0),
      created_at: start_time,
      updated_at: start_time
    )
  end
  start_time += 1.minute
end

