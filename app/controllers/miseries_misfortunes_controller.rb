class MiseriesMisfortunesController < ApplicationController

  def index
    @npc = MmNpcGenerator.new.call
  end

  def show
  end
end
