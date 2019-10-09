# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({email: 'foo@bar.com', password:'password', password_confirmation: 'password'})
['low' 'medium', 'high'].each { |status| Priority.create(status: status) }
[
  { user: User.first, priority: Priority.where(status: 'low').first, title: 'Test 1', body: 'This is test 1.' },
  { user: User.first, priority: Priority.where(status: 'medium').first, title: 'Test 2', body: 'This is test 2.' },
  { user: User.first, priority: Priority.where(status: 'high').first, title: 'Test 3', body: 'This is test 3.' },
  { user: User.first, priority: Priority.where(status: 'low').first, title: 'Test 4', body: 'This is test 4.' },
].each { |obj| Note.create(obj) }
