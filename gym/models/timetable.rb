require_relative( '../db/sql_runner' )

class Timetable

  attr_reader :id , :session_id
  attr_accessor :session_time , :capacity , :f_name 

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
    values = [@session_id,@session_time,@capacity,@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all

    sql = "DELETE FROM timetables;"

    SqlRunner.run(sql)

  end

  def self.all

    sql = "SELECT * FROM timetables"

    all = SqlRunner.run(sql)

    all.map do |schedule|
       Timetable.new(schedule)
    end

  end

  def self.attendance(id)

    sql =  "SELECT members.* , bookings.id as booking_id FROM members
    INNER JOIN bookings
    ON bookings.member_id = members.id
    INNER JOIN timetables
    ON bookings.timetable_id = timetables.id
    WHERE timetables.id = $1
    "

    members = SqlRunner.run(sql,[id])
    array = []
    list = members.map do |mem|
      array << mem

    end
    return array

  end
  #
  # def self.people_booked(id)
  #
  #   sql = "Select members.* from members
  #   INNER JOIN bookings
  #   on members.id = bookings.member_id
  #   INNER JOIN timetables
  #   ON bookings.timetable_id = timetables.id
  #   WHERE timetables.id = $1"
  #
  #   members = SqlRunner.run(sql,[id])
  #
  #   list = members.map do |mem|
  #

  def update()
    sql = "UPDATE timetables
    SET
    (
      session_id,
      session_time,
      capacity
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@session_id,@session_time,@capacity,@id]
    SqlRunner.run( sql, values )
  end

  def self.show_class_times

    sql = "SELECT timetables.*, sessions.name, sessions.premium FROM sessions
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


  def self.find(id)

    sql = "SELECT * FROM timetables
    WHERE id = $1"

    timetable = SqlRunner.run(sql,[id])

    return Timetable.new(timetable.first)

  end

  def self.delete(id)

    sql = "DELETE FROM timetables
    WHERE id = $1"

    SqlRunner.run(sql,[id])

  end

  def subtract()
    @capacity -= 1
    update()
  end

  def self.subtract(id)
    timetable = Timetable.find(id)
    timetable.capacity -= 1
    timetable.update
  end

  def self.add(id)
    timetable = Timetable.find(id)
    timetable.capacity += 1
    timetable.update
  end



end
