require_relative( '../db/sql_runner' )

class Booking

  attr_reader :member_id ,:timetable_id , :id

  def initialize(options)
    @id = options['id'].to_i
    @member_id = options['member_id'].to_i
    @timetable_id = options['timetable_id'].to_i
  end

  def save

    sql = "INSERT INTO bookings(
    member_id,
    timetable_id
    )
    VALUES($1,$2)
    RETURNING ID;"

    values = [@member_id,@timetable_id]

    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

  end

  def update()
    sql = "UPDATE bookings
    SET
    (
      member_id,
      timetable_id
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@member_id,@timetable_id,@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all

    sql = "DELETE FROM bookings;"

    SqlRunner.run(sql)

  end

  def self.all

    sql = "SELECT * FROM bookings"

    all = SqlRunner.run(sql)

    return all.map do |booking|
      Booking.new(booking)
    end
  end

  def self.find(id)

    sql = "SELECT * FROM bookings
    WHERE id = $1"


    booking = SqlRunner.run(sql,[id])

    return Booking.new(booking.first)

  end

  def delete()

    sql = "DELETE FROM bookings
    WHERE id = $1"

    SqlRunner.run(sql,@id)

  end

  def self.delete_find(id)

    sql = "DELETE FROM bookings
    WHERE id = $1"

    SqlRunner.run(sql,[id])

  end


end
