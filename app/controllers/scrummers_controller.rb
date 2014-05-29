class ScrummersController < ApplicationController

  respond_to :json
  protect_from_forgery except: :create

  def index
    @scrummers = Scrummer.all
  end

  def show
    respond_with Scrummer.find(params[:id])
  end

  def create
    respond_with Scrummer.create(params.permit(:name, :team))
  end

  def update
    respond_with Scrummer.update(params[:id], params[:scrummer])
  end

  def destroy
    respond_with Scrummer.destroy(params[:id])
  end
end
