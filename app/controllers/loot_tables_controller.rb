class LootTablesController < ApplicationController
  before_action :set_loot_table, only: %i[ show edit update destroy roll ]

  # GET /loot_tables or /loot_tables.json
  def index
    @loot_tables = LootTable.all
  end

  # GET /loot_tables/1 or /loot_tables/1.json
  def show
  end

  # GET /loot_tables/new
  def new
    @loot_table = LootTable.new
  end

  # GET /loot_tables/1/edit
  def edit
  end

  # POST /loot_tables or /loot_tables.json
  def create
    @loot_table = LootTable.new(loot_table_params)

    respond_to do |format|
      if @loot_table.save
        format.html { redirect_to loot_table_url(@loot_table), notice: "Loot table was successfully created." }
        format.json { render :show, status: :created, location: @loot_table }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loot_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loot_tables/1 or /loot_tables/1.json
  def update
    respond_to do |format|
      if @loot_table.update(loot_table_params)
        format.html { redirect_to loot_table_url(@loot_table), notice: "Loot table was successfully updated." }
        format.json { render :show, status: :ok, location: @loot_table }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loot_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loot_tables/1 or /loot_tables/1.json
  def destroy
    @loot_table.destroy!

    respond_to do |format|
      format.html { redirect_to loot_tables_url, notice: "Loot table was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /loot_tables/1/roll
  def roll
    @roll = @loot_table.roll()
    respond_to do |format|
      format.turbo_stream { render :roll }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loot_table
      @loot_table = LootTable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loot_table_params
      params.require(:loot_table).permit(:title)
    end
end
