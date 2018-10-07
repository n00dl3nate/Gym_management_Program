require_relative( '../db/sql_runner' )


class Session

  attr_accessor :name, :fitness_level
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @fitness_level = options['fitness_level'].to_i
  end

  def save

    sql = "INSERT INTO sessions
    (name,
    fitness_level
    )
    VALUES($1,$2)
    RETURNING ID;"

    values = [@name,@fitness_level]
    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

  end

  def self.delete_all

    sql = "DELETE FROM sessions;"

    SqlRunner.run(sql)

  end

  def self.all

    sql = "SELECT * FROM sessions"

    all = SqlRunner.run(sql)

    return all.map do |sesh|
      Session.new(sesh)
    end
  end

end
