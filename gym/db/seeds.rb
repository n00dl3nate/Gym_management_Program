require_relative('../models/members.rb')

member1 = Member.new(
  "f_name" => "Jack",
  "l_name" => "Jackson",
  "premium" => true,
  "fitness_level" => 3
)

member2 = Member.new(
  "f_name" => "Kris",
  "l_name" => "Kyle",
  "premium" => true,
  "fitness_level" => 1
)

member3 = Member.new(
  "f_name" => "Billy",
  "l_name" => "Brown",
  "premium" => true,
  "fitness_level" => 2
)

member4 = Member.new(
  "f_name" => "Simon",
  "l_name" => "Sugar",
  "premium" => false,
  "fitness_level" => 3
)

member1.save
member2.save
member3.save
member4.save
