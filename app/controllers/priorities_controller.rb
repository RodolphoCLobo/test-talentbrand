class PrioritiesController < ApplicationController

  before_action :set_priority, only: [:edit, :update, :destroy]

  def set_priority
    @priority = Priority.where(id: params[:id]).first
  end

  def create
    priority = Priority.create(priority_params)
    if priority.save
      Rails.env.test? ? render(json: priority, status: 201) : redirect_to(priorities_path)
    else
      if Rails.env.test?
        render json: { message: priority.errors.full_messages.first }, status: 417
      else
        redirect_to priorities_path, alert: priority.errors.full_messages.first
      end
    end
  end

  def index
    @priorities = Priority.all
    render(json: @priorities)if Rails.env.test?
  end

  def update
    if @priority.update(priority_params)
      Rails.env.test? ? render(json: @priority, status: 200) : redirect_to(priorities_path)
    else
      if Rails.env.test?
        render json: { message: @priority.errors.full_messages.first }, status: 417
      else
        redirect_to priorities_path, alert: @priority.errors.full_messages.first
      end
    end
  end

  def destroy
    if @priority.present? && @priority.destroy
      Rails.env.test? ? render(json: @priority, status: 200) : redirect_to(priorities_path)
    else
      if Rails.env.test?
        render json: { message: 'Priority not found.' }, status: 400
      else
        redirect_to priorities_path, alert: @priority.errors.full_messages.first
      end
    end
  end

  private

  def priority_params
    params.require(:priority).permit(:status)
  end
end
