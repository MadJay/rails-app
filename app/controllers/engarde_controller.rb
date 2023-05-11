class EngardeController < ApplicationController

  def index
  end

  def show
    case params[:id]
    when 'character'
      @character = RandomEngardeCharacter.new.call
    when 'companion'
      @companion = RandomEngardeCompanion.new.call
    end
  end

end

