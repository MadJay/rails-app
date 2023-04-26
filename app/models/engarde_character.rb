# == Schema Information
#
# Table name: engarde_characters
#
#  id            :bigint           not null, primary key
#  allowance     :integer
#  birth_class   :string
#  birth_rank    :string
#  con           :integer
#  end           :integer
#  exp           :integer
#  inheritance   :integer
#  initial_funds :integer
#  ma            :integer
#  name          :string
#  position      :string
#  social_level  :integer
#  str           :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class EngardeCharacter < ApplicationRecord

end
