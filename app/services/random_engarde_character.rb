class RandomEngardeCharacter
attr_reader :tables, :character

  def initialize
    @tables =  YAML::load(File.open("#{Rails.root.to_s}/static_data/engarde.yml")).symbolize_keys
    @character = EngardeCharacter.new
  end

  def call
    @character.birth_class = @tables[:birth_class].sample
    @character.birth_rank = @tables[:sibling_rank].sample
    set_position
    set_social_levels
    set_stats
    set_1st_son if @character.birth_rank == @tables[:sibling_rank][0]
    set_bastard if @character.birth_rank == @tables[:sibling_rank][5]
    @character
  end

 def set_1st_son
  @character.initial_funds +=  @character.initial_funds * 0.10
  @character.allowance += @character.allowance * 0.10
  @character.social_level += 1
  if d6(1) == 1
  #  @character.sibling_rank = 'orphan' error!!
    @character.allowance = @character.initial_funds = 0
    if @character.birth_class == @tables[:birth_class][5]
      @character.social_level += 3
    end
  end
 end

 def set_bastard
  @character.initial_funds -=  @character.initial_funds * 0.10
  @character.allowance -= @character.allowance * 0.10
  @character.social_level -= 1
 end

  def set_stats
    @character.str = d6(3)
    @character.con = d6(3)
    @character.exp = d6(3)
    @character.end = (@character.str * @character.con)
    @character.ma = d6(1)
  end

  def d6(num)
    val =0
    (1..num).each do
      val += rand(1..6)
    end
    val
  end

  def set_position
    position = @tables[:fathers_position][@character.birth_class].sample
    if @character.birth_class == 'commoner'
      @character.position = position.keys[0]
    else
      @character.position = position.keys[0] + " " + @character.birth_class
    end

    @character.initial_funds = position['initial_funds']
    @character.allowance = position['allowance']
    @character.inheritance = position['inheritance']
  end

  def set_social_levels
   @character.social_level = 2 if @character.position == 'peasant'
   @character.social_level = 3 if @character.birth_class == 'commoner' && @character.position != 'peasant'
   @character.social_level = 4 if @character.birth_class == 'gentleman' && @character.initial_funds < 750
   @character.social_level = 5 if @character.birth_class == 'gentleman' && @character.initial_funds  == 750
   if @character.birth_class == 'nobleman'
    @character.social_level = get_title_level
   end
  end

  def get_title_level
    @character.position = @tables[:titles].sample
    case @character.position
    when 'knight'
      6
    when 'baron'
      7
    when 'marquis'
      8
    when 'earl'
      9
    when 'viscount'
      10
    when 'count'
      11
    end
  end
end