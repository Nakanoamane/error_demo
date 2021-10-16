class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
		@foods = Food.all
	end

	def edit
		@user = User.find(params[:id])
		@foods = Food.all
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@foods = Food.all
		if params[:raise_error]
			raise ActionController::BadRequest
		end

		@user = User.create!(user_params)
		redirect_to user_path(id: @user.id)

	rescue => e
		logger.error(e)
		@user = User.new(user_params)
		@error = e.message

		render :new
	end

	def update
		@foods = Food.all
		@user = User.find(params[:id])

		if params[:raise_error]
			raise ActionController::BadRequest
		end

		ActiveRecord::Base.transaction do
			@user.update!(user_params)
		end

		redirect_to user_path(id: @user.id)

	rescue => e
		logger.error(e)
		@user.assign_attributes(user_params)
		@error = e.message

		render :edit
	end

	private

	def user_params
		params.require(:user).permit(:name, food_ids: [])
	end

end