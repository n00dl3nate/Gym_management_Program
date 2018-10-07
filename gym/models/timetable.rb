require_relative( '../db/sql_runner' )

class Timetable

  attr_reader :id , :class_id
  attr_accessor :class_time , :capacity

  def initialize(options)
    @id = options['id'].to_i
    @session_id = options['session_id'].to_i
    @class_time = options['class_time']
    @capacity = options['capacity'].to_i
  end

  def save

    sql = "INSERT INTO timetables(
    session_id,
    class_time,
    capacity
    )
    VALUES($1,$2,$3)
    RETURNING ID;
    "

    values = [@session_id,@class_time,@capacity]

    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

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

end
