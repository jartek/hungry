Client.where(name: 'truffles').first_or_create({
  email: 'truffles@truffles.com',
  uid: 'truffles@truffles.com',
  provider: 'email',
  password: 'a'*8,
  password_confirmation: 'a'*8
})
