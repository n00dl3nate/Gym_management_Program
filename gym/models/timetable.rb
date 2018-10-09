require_relative( '../db/sql_runner' )

class Timetable

  attr_reader :id , :class_id
  attr_accessor :class_time , :capacity

  def initialize(options)
    @id = options['id'].to_i
    @session_id = options['session_id'].to_i
    @session_time = options['session_time']
    @capacity = options['capacity'].to_i
  end

  def save

    sql = "INSERT INTO timetables(
    session_id,
    session_time,
    capacity
    )
    VALUES($1,$2,$3)
    RETURNING ID;
    "

    values = [@session_id,@session_time,@capacity]

    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

  end

  def update()
    sql = "UPDATE members
    SET
    (
      session_id,
      session_time,
      capacity
    ) =
    (
      $1, $2 , $3
    )
    WHERE id = $4"
    values = [@session_id,@session_time,@capacity]
    SqlRunner.run( sql, values )
  end

  def self.delete_all

    sql = "DELETE FROM timetables;"

    SqlRunner.run(sql)

  end

  def self.all

    sql = "SELECT * FROM timetables"

    all = SqlRUnner.run(sql)

    all.map do |schedule|
      return Timetable.new(schedule)
    end

  end

  def attendance

    sql =  "SELECT members.* FROM members
    INNER JOIN bookings
    ON bookings.member_id = members.id
    INNER JOIN timetables
    ON bookings.timetable_id = timetables.id
    WHERE timetables.id = $1
    "

    members = SqlRunner.run(sql,[@id])

    list = members.map do |mem|
      Member.new(mem)
    end
    return list

  end

  def update()
    sql = "UPDATE timetables
    SET
    (
      session_time,
      capacity
    )
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@session_time,@capacity,@id]
    SqlRunner.run( sql, values )
  end

  def self.show_class_times

    sql = "SELECT timetables.*, sessions.name FROM sessions
    INNER JOIN timetables
    ON timetables.session_id = sessions.id
    Order by timetables.session_time"

    results = SqlRunner.run(sql)
    all = []
    results.each do |item|
      all << item
    end
    return all
  end

end
