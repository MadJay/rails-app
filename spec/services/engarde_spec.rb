require 'rails_helper'

RSpec.describe RandomEngardeCharacter, type: :model do
  let (:engarde) { RandomEngardeCharacter.new}

  it "better have some tables " do
    engarde.call
    puts "Character #{engarde.character}"
    expect(engarde.tables[:birth_class].length).to eq(3)
    expect(engarde.character.birth_class).to be
    expect(engarde.character.birth_rank).to  be
    expect(engarde.character.position).to be
    expect(engarde.character.allowance).to be
    expect(engarde.character.inital_funds).to be
    expect(engarde.character.inheritance).to be
  end
end
