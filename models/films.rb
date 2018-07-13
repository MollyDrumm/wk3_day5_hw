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
end
