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

    values = [@f_name,@l_name,@premium,@fitness_level]

    id = SqlRunner.run(sql,values)
    @id = id.first['id'].to_i

  end

end
