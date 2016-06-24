class AboutController < ApplicationController

	def home
	@periods = Period.all.limit(3).shuffle
	render :index
	end
end
