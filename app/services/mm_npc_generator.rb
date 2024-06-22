class MmNpcGenerator

  def initialize
    @tables =  YAML::load(File.open("#{Rails.root.to_s}/static_data/mm_npc.yml")).symbolize_keys
    @relations = @tables[:relation]
    @dependents = @tables[:dependents]
    @wealth_rank = @tables[:wealth_rank]
    @debt = @tables[:debt]
    @politics = @tables[:politics]
    @religion = @tables[:religion]
    @abilities = @tables[:abilities]
    @mods = @tables[:score_mod]
    @character = {}
  end

  def call
    get_birth_quality
    set_wealth
    set_dependents
    calc_debt
    set_mentalities
    roll_ability_scores
    @character
  end

  def roll_ability_scores
    @abilities.each do |ability|
      @character[ability] = dice('3d6')
      @character["#{ability}_mod"] = get_table_entry(@mods, @character[ability])
    end

  end

  def set_mentalities
    @character[:religion] = get_table_entry(@religion, dice('2d6'))
    @character[:politics] = get_table_entry(@politics, dice('2d6'))
  end

  def get_birth_quality
    bc_roll = DiceBag.roll('3d6').total
    bc = get_table_object(@tables[:birth_quality],bc_roll)
    @character[:bc_roll] = bc_roll
    @character[:birth_quality] = bc[:class]
    @character[:obligations] = bc[:obligations]
    @character[:text] = bc[:text]
    @character[:income_source] = get_table_entry( bc[:income_source], DiceBag.roll('1d6').total)
    @character[:noble] = true if bc_roll > 15
    @character[:income_range] = 0
  end

  def set_wealth
    row = @tables[:income_range][@character[:income_source]]
    @character[:income_range] = DiceBag.roll( row['range']).total unless row['range'] == 0
    @character[:property] = get_table_entry(row['property'], DiceBag.roll('1d6').total )
    prop = @tables[:property][@character[:property]]
    @character[:obligations] += prop[0]
    @character[:income_range] += prop[1]
    @character[:asset_value] = prop[2]
    if @wealth_rank.key?(@character[:income_range])
      @character[:wealth_rank] = @wealth_rank[@character[:income_range]][0]
    else
      puts "Could not find income range #{@character[:income_range]}"
    end
  end

  def set_dependents
    roll = DiceBag.roll('1d4-1').total
    @character[:dependents] = []
    (0..roll).each do |row|
      dep = @dependents[DiceBag.roll('1d20').total]
      relation = get_table_entry(@relations, dice('1d6'))
      @character[:dependents] <<  "#{dep} (#{relation})"
    end
  end

  def calc_debt
    roll = dice('1d6')
    @character[:debt] = get_table_entry(@debt, roll)
    if roll > 1 && roll < 6
      @character[:obligations] += (5 - roll)
    end
    @character[:obligations] += @character[:dependents].length
  end

  def dice( exp)
    DiceBag.roll(exp).total
  end

  def get_table_entry( table, index)
    table.each do |item|
      if item.keys.first.to_i >= index
        return item.values.first
      end
    end
  end

  def get_table_object( table, index)
    result = ""
    table.each do | item|
      if item['index'] >= index
        return item.symbolize_keys
      end
    end
      result
  end
end ###