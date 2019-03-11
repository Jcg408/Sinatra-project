#seed data for application
#users-
betty = User.create(first_name: "Betty", last_name: "Boop", username: "bboop", email: "bboop@boop.com", password: "boopaloop")
jessica = User.create(first_name: "Jessica", last_name: "Rabbit", username: "jessbest", email: "jrabbit@you.com", password: "imnotbad")

#travel-
Travel.create(itinerary: "New York, NY - Boston, MA", date_leave: 15/3/2019, date_return: 17/3/2019, travel_purpose: "wedding for friend",
notes: "Nice wedding", user_id: betty.id)

jessica.travels.create(itinerary: "Miami, FL - Barcelona, Spain", date_leave: 13/10/2018, date_return: 20/10/2018, travel_purpose: "vacation",
    notes: "Viva Espana",)

