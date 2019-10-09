class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :destroy]
  before_action :set_priorities, only: [:edit, :new, :update]

  def set_note
    @note = Note.where(id: params[:id]).first
  end

  def set_priorities
    @priorities = Priority.all
  end

  def create
    note = Note.create(note_params)
    if note.save
      Rails.env.test? ? render(json: note, status: 201) : redirect_to(notes_path)
    else
      if Rails.env.test?
        render json: { message: note.errors.full_messages.first }, status: 417
      else
        redirect_to notes_path, alert: note.errors.full_messages.first
      end
    end
  end

  def index
    if params[:q].present?
      @notes = Note.where(title: params[:q])
      @notes = Note.all if @notes.empty?
    else
      @notes = Note.all
    end
    render json: @notes if Rails.env.test?
  end

  def update
    if @note.update(note_params)
      Rails.env.test? ? render(json: @note, status: 200) : redirect_to(notes_path)
    else
      if Rails.env.test?
        render json: { message: @note.errors.full_messages.first }, status: 417
      else
        redirect_to notes_path, alert: @note.errors.full_messages.first
      end
    end
  end

  def destroy
    if @note.present? && @note.destroy
      Rails.env.test? ? render(json: @note, status: 200) : redirect_to(notes_path)
    else
      if Rails.env.test?
        render json: { message: 'Note not found.' }, status: 400
      else
        redirect_to notes_path, alert: @note.errors.full_messages.first
      end
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, :user_id, :priority_id)
  end
end
