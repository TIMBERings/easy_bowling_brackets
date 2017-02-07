class BracketGroupsController < ApplicationController
  before_action :set_bracket_group, only: [:show, :update, :destroy]

  # GET /bracket_groups
  # GET /bracket_groups.json
  def index
    @bracket_groups = BracketGroup.all
  end

  # GET /bracket_groups/1
  # GET /bracket_groups/1.json
  def show
  end

  # POST /bracket_groups
  # POST /bracket_groups.json
  def create
    @bracket_group = BracketGroup.new(bracket_group_params)

    if @bracket_group.save
      render :show, status: :created, location: @bracket_group
    else
      render json: @bracket_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bracket_groups/1
  # PATCH/PUT /bracket_groups/1.json
  def update
    if @bracket_group.update(bracket_group_params)
      render :show, status: :ok, location: @bracket_group
    else
      render json: @bracket_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bracket_groups/1
  # DELETE /bracket_groups/1.json
  def destroy
    @bracket_group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracket_group
      @bracket_group = BracketGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracket_group_params
      params.require(:bracket_group).permit(:name, :event_id)
    end
end
