class RandomEngardeCompanion

  Companion = Struct.new( :social_level, :has_wealth, :has_beauty, :has_influence)
  def call
    Companion.new( DiceBag::Roll.new("3d6").result.total, has_trait?, has_trait?, has_trait?)
  end

  def has_trait?
    DiceBag::Roll.new("1d6").result.total < 3
  end
end