require ( 'pry-byebug' )

require_relative('../models/films')
require_relative('../models/customers')
require_relative('../models/tickets')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


film1 = Film.new({ 'title' => 'Misery', 'price' => '7'})
film2 = Film.new({ 'title' => 'Midnight Express', 'price' => '8'})
film3 = Film.new({ 'title' => 'About a boy', 'price' => '5'})

film1.save()
film2.save()
film3.save()




customer1 = Customer.new({ 'name' => 'Fiona', 'funds' => '10'})
customer2 = Customer.new({ 'name' => 'Kirsty', 'funds' => '30'})
customer3 = Customer.new({ 'name' => 'Anna', 'funds' => '20'})

customer1.save()
customer2.save()
customer3.save()

# customer1.delete()

ticket1 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id })
ticket1.save
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id })
ticket2.save
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id })
 ticket3.save
