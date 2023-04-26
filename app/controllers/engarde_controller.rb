class EngardeController < ApplicationController

  def index
    @character = RandomEngardeCharacter.new.call
    logger.info "character: #{@character.inspect}"
  end
end

