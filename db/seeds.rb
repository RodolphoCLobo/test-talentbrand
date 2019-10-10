User.delete_all
Priority.delete_all
Note.delete_all

User.create(email: 'foo@bar.com', password:'password', password_confirmation: 'password')
Priority.create(status: 'low')
Priority.create(status: 'medium')
Priority.create(status: 'high')
Note.create(user: User.first, priority: Priority.where(status: 'low').first, title: 'Test tilte 1', body: 'This is test note 1.')
Note.create(user: User.first, priority: Priority.where(status: 'medium').first, title: 'Test tilte 2', body: 'This is test note 2.')
Note.create(user: User.first, priority: Priority.where(status: 'high').first, title: 'Test tilte 3', body: 'This is test note 3.')
Note.create(user: User.first, priority: Priority.where(status: 'low').first, title: 'Test tilte 4', body: 'This is test note 4.')
