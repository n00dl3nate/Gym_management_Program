require_relative( '../db/sql_runner' )

class Member

  attr_accessor :f_name, :l_name, :premium, :fitness_level
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @f_name = options['f_name']
    @l_name = options['l_name']
    @premium = options['premium']
    @fitness_level = options['fitness_level'].to_i
  end

  def save

    sql = "INSERT INTO members (
    f_name,
    l_name,
    premium,
    fitness_level
    )
    VALUES($1,$2,$3,$4)
    RETURNING ID;"

    values = [@f_name.capitalize,@l_name.capitalize,@premium,@fitness_level]

    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

  end

  def update()
    sql = "UPDATE members
    SET
    (
      f_name,
      l_name,
      premium,
      fitness_level
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@f_name,@l_name,@premium,@fitness_level, @id]
    SqlRunner.run( sql, values )
  end



  def self.delete_all

    sql = "DELETE FROM members;"

    SqlRunner.run(sql)

  end

  def self.all

    sql = "SELECT * FROM members"

    all = SqlRunner.run(sql)

    return all.map do |member|
      Member.new(member)
    end
  end

  def self.find(id)

    sql = "SELECT * FROM members
    WHERE id = $1"


    member = SqlRunner.run(sql,[id])

    return Member.new(member.first)

  end

  def delete()

    sql = "DELETE FROM members
    WHERE id = $1"

    SqlRunner.run(sql,[@id])

  end

  def self.amount

    all = Member.all
    return all.length

  end

  def self.show_bookings(id)

    sql = "SELECT bookings.id ,sessions.name, sessions.fitness_level ,
    timetables.session_time , timetables.id as t_id FROM sessions
    INNER JOIN timetables
    ON timetables.session_id = sessions.id
    INNER JOIN bookings
    ON bookings.timetable_id = timetables.id
    INNER JOIN members
    ON members.id = bookings.member_id
    WHERE members.id = $1"

    booked = SqlRunner.run(sql,[id])
    all = []
    booked.each do |session|
      all << session
    end
    return all
  end

  def self.search_by_name(name)

    members = Member.all
    searched = []
    members.each do |mem|
      if mem.f_name.to_s.downcase.include?(name.to_s) == true || mem.l_name.to_s.downcase.include?(name.to_s)
        searched << mem
      end
    end
    return searched
    
  end





end
