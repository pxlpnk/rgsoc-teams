class Conf
  attr_reader :name, :tickets, :flights

  def initialize(name, tickets, flights)
    @name = name.downcase
    @tickets = tickets
    @flights = flights
  end

  def tickets?
    tickets > 0
  end

  def flights?
    flights > 0
  end

  def attend(app)
    raise("#{app} is trying to attend #{name}, but there are no tickets left.") unless tickets?
    @tickets -= 1
    if flights?
      app.flight = true
      @flights -= 1
    end
  end

  def to_row
    [name, tickets, flights]
  end

  def <=> (other)
    name <=> other.name
  end
end
