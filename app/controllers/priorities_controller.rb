class PrioritiesController < ApplicationController

  before_action :set_priority, only: [:update, :destroy]

  def set_priority
    @priority = Priority.where(id: params[:id]).first
  end

  def create
    priority = Priority.create(priority_params)
    if priority.save
      render json: priority, status: 201
    else
      render json: { message: priority.errors.full_messages.first }
    end
  end

  def update
    if @priority.update(priority_params)
      render json: @priority, status: 200
    else
      render json: { message: @priority.errors.full_messages.first }, status: 417
    end
  end

  def destroy
    if !@priority.nil? && @priority.delete
      render json: @priority, status: 200
    else
      render json: { message: 'Priority not found.' }, status: 400
    end
  end

  private

  def priority_params
    params.require(:priority).permit(:status)
  end
end
