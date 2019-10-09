User.create({email: 'foo@bar.com', password:'password', password_confirmation: 'password'})
['low' 'medium', 'high'].each { |status| Priority.create(status: status) }
[
  { user: User.first, priority: Priority.where(status: 'low').first, title: 'Test 1', body: 'This is test 1.' },
  { user: User.first, priority: Priority.where(status: 'medium').first, title: 'Test 2', body: 'This is test 2.' },
  { user: User.first, priority: Priority.where(status: 'high').first, title: 'Test 3', body: 'This is test 3.' },
  { user: User.first, priority: Priority.where(status: 'low').first, title: 'Test 4', body: 'This is test 4.' },
].each { |obj| Note.create(obj) }
