# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Goal.destroy_all
Comment.destroy_all

ApplicationRecord.connection.reset_pk_sequence!('goals')
ApplicationRecord.connection.reset_pk_sequence!('comments')

renata = User.find_by(username: 'renata')
jen = User.find_by(username: 'jen')
clint = User.find_by(username: 'clint')
nancy = User.find_by(username: 'nancy')
skyler = User.find_by(username: 'skyler')
lance = User.find_by(username: 'lance')

renata_4000 = Goal.create({
  user_id: renata.id,
  title: 'Hike the New Hampshire 4,000 footers',
  description: 'Hike to the top of all the mountains in New Hampshire whose elevation is taller than 4,000 feet above sea level',
  privacy: 'Public'
})

renata_cupcakes = Goal.create({
  user_id: renata.id,
  title: 'Eat a cupcake from all the bakeries in Boston',
  description: "Try a vanilla cupcake from each bakery, keeping track of my favorites. When I'm done, I can have a blind taste test with the finalists.",
  privacy: 'Public'
})

renata_pullups = Goal.create({
  user_id: renata.id,
  title: 'Do 10 pull-ups in a row',
  description: '',
  privacy: 'Public'
})

jen_4000 = Goal.create({
  user_id: jen.id,
  title: 'Hike all 48 New Hampshire 4,000 footers',
  description: 'With Renata!',
  privacy: 'Public'
})

clint_coins = Goal.create({
  user_id: clint.id,
  title: 'Finish the 1845 Liberty Seated Half Dime attribution guide',
  description: '',
  privacy: 'Public'
})

nancy_swimming = Goal.create({
  user_id: nancy.id,
  title: 'Swim in a lake at the bottom of a waterfall in Iceland',
  description: '',
  privacy: 'Public'
})

skyler_climb = Goal.create({
  user_id: skyler.id,
  title: 'Climb a pitch with a rating of 5.14',
  description: '',
  privacy: 'Public'
})

lance_garden = Goal.create({
  user_id: lance.id,
  title: 'Make a whole salad using only plants that I grew myself',
  description: '',
  privacy: 'Public'
})

Comment.create({
  commentable_id: renata.id,
  commentable_type: "User",
  author_id: renata.id,
  comment_text: 'I want to add another goal! Does anyone have any ideas?'
})

Comment.create({
  commentable_id: renata.id,
  commentable_type: "User",
  author_id: jen.id,
  comment_text: 'How about a goal for your strength workouts at the gym?'
})

Comment.create({
  commentable_id: renata.id,
  commentable_type: "User",
  author_id: renata.id,
  comment_text: 'Great idea, thanks Jen! I added a goal for pull-ups!'
})

Comment.create({
  commentable_id: jen_4000.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "I'm excited to work towards this goal with you!"
})

Comment.create({
  commentable_id: renata_4000.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "So far, we've done 3! 45 to go!"
})

Comment.create({
  commentable_id: renata_cupcakes.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "So far, my favorite cupcake is from Magnolia Bakery, but I'm not done yet..."
})

Comment.create({
  commentable_id: clint_coins.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "Cool! How many other half dime guides have you finished?"
})

Comment.create({
  commentable_id: nancy_swimming.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "Sounds amazing! I hope it's not too cold!"
})

Comment.create({
  commentable_id: skyler_climb.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "That would be incredible! What's the hardest climb you've done so far?"
})

Comment.create({
  commentable_id: lance_garden.id,
  commentable_type: "Goal",
  author_id: renata.id,
  comment_text: "I'm sure it will be a delicious salad! What ingredients do you want to include?"
})
