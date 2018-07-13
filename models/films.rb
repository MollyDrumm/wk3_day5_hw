require_relative('../db/sql_runner')
require_relative( 'customers' )
require_relative( 'tickets' )


class Film
  attr_reader :id, :title, :price
  attr_writer :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
  sql = "INSERT INTO films (title, price)
  VALUES ($1, $2)
  RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run( sql, values ).first
  @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1,$2) WHERE id = $3"
    values = [ @title, @price, @id]
    films = SqlRunner.run(sql, values)
    return films
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    film_hash = result.first
    return Customer.new(film_hash)
  end

  def self.all
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film|     Film.new( film ) }
    return result
  end

  def customer()
  sql = "SELECT customers.* FROM customers
        INNER JOIN tickets
          ON customers.id = tickets.customer_id
        WHERE tickets.film_id = $1;"
  values = [@id]
  result = SqlRunner.run(sql, values)
  customers = result.map { |customer| Customer.new(customer) }
  return customers
end

  def self.delete_all()
     sql = "DELETE FROM films"
     SqlRunner.run(sql)
   end

   def delete()
     sql = "DELETE FROM films WHERE id = $1"
     values = [@id]
     SqlRunner.run(sql, values)
   end

end
