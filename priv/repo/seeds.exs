alias FoodOrder.Accounts

Accounts.register_user(%{
  email: "adm@elxpro.com",
  password: "Adm@elxpro.com",
  role: "ADMIN"
})

Accounts.register_user(%{
  email: "user@elxpro.com",
  password: "User@elxpro.com",
  role: "USER"
})

Accounts.register_user(%{
  email: "romenig@elxpro.com",
  password: "Romenig@elxpro.com"
})
