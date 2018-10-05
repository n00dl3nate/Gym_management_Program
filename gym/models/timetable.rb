require_relative( '../db/sql_runner' )

class Timetable

  attr_reader :id , :class_id
  attr_accessor :class_time , :capacity

  def initialize(options)
    @id = options['id'].to_i
    @class_id = options['class_id'].to_i
    @class_time = options['class_time']
    @capacity = options['capacity'].to_i
  end

  def save

    sql = "INSERT INTO timetables(
    class_id,
    class_time,
    capacity
    )
    VALUES($1,$2,$3)
    RETURNING ID;
    "

    values = [@class_id,@class_time,@capacity]

    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

  end

end
