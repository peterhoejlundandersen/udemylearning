class PortfoliosController < ApplicationController
	before_action :set_portfolio, only: [:edit, :show, :update, :destroy]
	layout "portfolio"
	access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all

	def index
		@portfolio_items = Portfolio.by_position
	end	

	def sort
		params[:order].each do |key, value|
			Portfolio.find(value[:id]).update(position: value[:position])
		end

		render nothing: true
	end

	def angular
		@angular_portfolio_items = Portfolio.angular
	end

	def show
		@portfolio_item = Portfolio.find(params[:id])
	end

	def new
		@portfolio_item = Portfolio.new
		3.times { @portfolio_item.technologies.build }
	end



	def create 
		@portfolio_item = Portfolio.new(portfolio_params)

		respond_to do |format| 
			if @portfolio_item.save
				format.html { redirect_to portfolios_path , notice: "Your portfolio item was saved."}
			else
				format.html { render :new }			
			end
		end

	end

	def edit
		@portfolio_item = Portfolio.find(params[:id])		
		3.times { @portfolio_item.technologies.build }

	end

	def update
		respond_to do |format|
			if @portfolio_item.update_attributes(portfolio_params)
				format.html { redirect_to portfolios_path, notice: "Item was succesfully created."}
			else
				format.html { render :edit }
			end 
		end
	end


	def destroy
		@portfolio_item.destroy
		respond_to do |format|
			format.html { redirect_to portfolios_path, notice: "Portfolio_item was removed."}

		end	
	end
	private 

	def portfolio_params
		params.require(:portfolio).permit(:title, 
			:subtitle, 
			:body, 
			{technologies_attributes: [:name]}
			)
	end

	def set_portfolio
		@portfolio_item = Portfolio.find(params[:id])
	end
end
