class NotesController < ApplicationController
  before_action :set_note, only: [:update, :destroy]

  def set_note
    @note = Note.where(id: params[:id]).first
  end

  def create
    note = Note.create(note_params)
    if note.save
      render json: note, status: 201
    else
      render json: { message: note.errors.full_messages.first }
    end
  end

  def update
    if @note.update(note_params)
      render json: @note, status: 200
    else
      render json: { message: @note.errors.full_messages.first }, status: 417
    end
  end

  def destroy
    if !@note.nil? && @note.delete
      render json: @note, status: 200
    else
      render json: { message: 'Note not found.' }, status: 400
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, :user_id, :priority_id)
  end
end
