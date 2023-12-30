class RollsController < ApplicationController
  before_action :set_loot_table, only: %i[ create ]

  # POST /rolls or /rolls.json
  def create
    @roll = @loot_table.rolls.build(roll_params)

    respond_to do |format|
      if @roll.save
        format.turbo_stream
        format.html { redirect_to loot_table_url(@roll.loot_table), notice: "Roll was successfully created." }
        format.json { render :show, status: :created, location: @roll }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
    def set_loot_table
      @loot_table = LootTable.find(params[:loot_table_id])
    end

    # Only allow a list of trusted parameters through.
    def roll_params
      params.require(:roll).permit(:quantity, :loot_table_id)
    end
end
