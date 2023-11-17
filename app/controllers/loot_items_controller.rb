class LootItemsController < ApplicationController
  before_action :get_loot_table
  before_action :set_loot_item, only: %i[ show edit update destroy ]

  # GET /loot_items or /loot_items.json
  def index
    @loot_items = @loot_table.loot_items
  end

  # GET /loot_items/1 or /loot_items/1.json
  def show
  end

  # GET /loot_items/new
  def new
    @loot_item = @loot_table.loot_items.build
    @tables = LootTable.all
  end

  # GET /loot_items/1/edit
  def edit
    @tables = LootTable.all
  end

  # POST /loot_items or /loot_items.json
  def create
    @loot_item = @loot_table.loot_items.build(loot_item_params)

    respond_to do |format|
      if @loot_item.save
        format.html { redirect_to loot_table_path(@loot_table), notice: "Loot item was successfully created." }
        format.json { render :show, status: :created, location: @loot_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loot_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loot_items/1 or /loot_items/1.json
  def update
    respond_to do |format|
      if @loot_item.update(loot_item_params)
        format.html { redirect_to loot_table_path(@loot_table), notice: "Loot item was successfully updated." }
        format.json { render :show, status: :ok, location: @loot_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loot_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loot_items/1 or /loot_items/1.json
  def destroy
    @loot_item.destroy!

    respond_to do |format|
      format.html { redirect_to loot_table_path(@loot_table), notice: "Loot item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loot_item
      @loot_item =@loot_table.loot_items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loot_item_params
      params.require(:loot_item).permit(:name, :probability, :loot_table_id, :always, :unique, :inner_table_id)
    end

    def get_loot_table
      @loot_table = LootTable.find(params[:loot_table_id])
    end
end
