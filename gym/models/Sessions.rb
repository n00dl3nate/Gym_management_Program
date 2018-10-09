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

  def update()
    sql = "UPDATE members
    SET
    (
      name,
      fitness_level
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name,@fitness_level]
    SqlRunner.run( sql, values )
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

  def self.times(id)

    sql = "SELECT timetables.session_time FROM sessions
    INNER JOIN timetables
    ON timetables.session_id = sessions.id
    WHERE sessions.id = $1
    "

    class_times = SqlRunner.run(sql,[id])

    all = []
    class_times.each do |session|
      all << session
    end
    return all
  end


end
