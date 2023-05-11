require 'rails_helper'

RSpec.describe RandomEngardeCharacter, type: :model do
  let (:engarde) { RandomEngardeCharacter.new}
  let (:companion) {RandomEngardeCompanion.new}

  it "better have some tables " do
    engarde.call
    puts "Character #{engarde.character}"
    expect(engarde.tables[:birth_class].length).to eq(3)
    expect(engarde.character.birth_class).to be
    expect(engarde.character.birth_rank).to  be
    expect(engarde.character.position).to be
    expect(engarde.character.allowance).to be
    expect(engarde.character.initial_funds).to be
    expect(engarde.character.inheritance).to be
  end

  it "should have a good companion" do
    comp = RandomEngardeCompanion.new.call
    expect(comp.social_level).to be
    expect(comp.has_wealth).not_to be_nil
    expect(comp.has_influence).not_to be_nil
    expect(comp.has_beauty).not_to be_nil
  end
end
