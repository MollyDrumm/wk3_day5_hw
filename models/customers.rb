require_relative('../db/sql_runner')

class Customer
  attr_reader :id, :name, :funds
  attr_writer :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    customer_hash = result.first
    return Customer.new(customer_hash)
  end

  def self.all
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer|     Customer.new( customer ) }
    return result
  end

 def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
