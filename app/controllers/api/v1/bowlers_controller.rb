module Api
  module V1
    class BowlersController < ApplicationController
      before_action :set_bowler, only: [:show, :update, :destroy]
      before_action :set_bracket, only: [:create]
      # GET /api/v1/bowlers.json
      def index
        render json: Bowler.all
      end

      # GET /api/v1/bowlers/1.json
      def show
        render json: @bowler
      end

      # POST /api/v1/bowlers.json
      def create
        render json: 'Bracket not found', status: :not_found unless @bracket
        @bowler = Bowler.new(bowler_params)

        if @bowler.save
          @bracket.bowlers << @bowler unless @bracket.bowlers.include? @bowler
          render json: @bowler, status: :created
        else
          render json: @bowler.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/bowlers/1.json
      def update
        if @bowler.update(bowler_params)
          render json: @bowler, status: :ok
        else
          render json: @bowler.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/bowlers/1
      # DELETE /api/v1/bowlers/1.json
      def destroy
        @bowler.destroy
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_bowler
          @bowler = Bowler.find(params[:id])
        end

        def set_bracket
          @bracket = Bracket.find(params[:bracket_id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def bowler_params
          params.require(:bowler).permit(:name, :starting_lane, :paid, :rejected_count, :entries, :average)
        end
    end
  end
end
