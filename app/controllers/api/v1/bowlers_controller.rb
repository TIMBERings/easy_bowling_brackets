module Api
  module V1
    class BowlersController < ApplicationController
      before_action :set_bowler, only: [:show, :edit, :update, :destroy]

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
        @bowler = Bowler.new(bowler_params)

        respond_to do |format|
          if @bowler.save
            render :show, status: :created, location: @bowler
          else
            render json: @bowler.errors, status: :unprocessable_entity
          end
        end
      end

      # PATCH/PUT /api/v1/bowlers/1.json
      def update
        respond_to do |format|
          if @bowler.update(bowler_params)
            format.html { redirect_to @bowler, notice: 'Bowler was successfully updated.' }
            format.json { render :show, status: :ok, location: @bowler }
          else
            format.html { render :edit }
            format.json { render json: @bowler.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /api/v1/bowlers/1
      # DELETE /api/v1/bowlers/1.json
      def destroy
        @bowler.destroy
        respond_to do |format|
          format.html { redirect_to bowlers_url, notice: 'Bowler was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_bowler
          @bowler = Bowler.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def bowler_params
          params.require(:bowler).permit(:name, :starting_lane, :paid, :rejected)
        end
    end
  end
end
