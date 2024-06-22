require 'rails_helper'

RSpec.describe MmNpcGenerator, type: :model do
  let (:mmnpc) {MmNpcGenerator.new}

  it "better have some tables " do
    npc = mmnpc.call
    expect(npc).to have_key(:birth_quality)
    expect(npc).to have_key(:income_source)
    puts "birth_quality: #{npc[:birth_quality]} and income_source: #{npc[:income_source]}"
    npc.keys.each do |key|
      puts " #{key} : #{npc[key]}"
    end
  end

end
