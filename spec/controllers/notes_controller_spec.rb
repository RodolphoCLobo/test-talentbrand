require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  login_user

  describe 'POST /notes' do
    context 'when params are valid.' do
      before do
        user = create(:random_user)
        priority = create(:priority)
        post :create, params: { note: {
         title: 'foo', body: 'bar', user_id: user.id, priority_id: priority.id
        } }
      end
      it 'should return status code 201.' do
        expect(response).to have_http_status(201)
      end
      it 'should return created note.' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:title]).to eq('foo')
      end
    end
    context 'when params are invalid.' do
      it 'should return error message' do
        user = create(:random_user)
        priority = create(:priority)
        post :create, params: { note: {
         title: 'foo', body: 'bar', priority_id: priority.id
        } }
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:message]).to eq("User can't be blank")
      end
    end
  end

  describe 'GET /notes' do
    context 'when no have params' do
      it 'should return all notes.' do
        user = create(:random_user)
        priority = create(:priority)
        for n in (1..3) do
          note = create(:note, user: user, priority: priority)
          n += 1
        end
        get :index
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result.count).to eq(Note.count)
      end
    end
  end

  describe 'GET /notes/:q' do
    context 'when part of title from params exists.' do
      it 'should return only notes with this part of title.' do
        q = 'title test'
        user = create(:random_user)
        priority = create(:priority)
        for n in (1..3) do
          if n == 2
            create(:note, user: user, priority: priority, title: q)
          else
            create(:note, user: user, priority: priority)
          end
          n += 1
        end
        get :index, params: { q: 'tes' }
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result.first[:title]).to eq(q)
        expect(result.count).to eq(1)
      end
    end
    context 'when title from params not exists.' do
      it 'should return all notes.' do
        q = 'title test'
        user = create(:random_user)
        priority = create(:priority)
        for n in (1..3) do
          create(:note, user: user, priority: priority)
          n += 1
        end
        get :index, params: { q: q }
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result.count).to eq(Note.count)
      end
    end
  end

  describe 'PUT /notes/:id' do
    context 'when params are valid.' do

      before do
        user = create(:random_user)
        priority = create(:priority)
        note = create(:note, user: user, priority: priority)
        put :update, params: { note: { title: 'updated_title' }, id: note.id }
      end

      it 'should return status code 200.' do
        expect(response).to have_http_status(200)
      end
      it 'should return updated note.' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:title]).to eq('updated_title')
      end
    end
    context 'when params are invalid.' do
      before do
        user = create(:random_user)
        priority = create(:priority)
        note = create(:note, user: user, priority: priority)
        put :update, params: { note: { title: nil }, id: note.id }
      end

      it 'should return status code 417.' do
        expect(response).to have_http_status(417)
      end
      it 'should return a error message' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:message]).to eq("Title can't be blank")
      end
    end
  end

  describe 'DELETE /notes/:id' do
    context 'when params are valid.' do

      before do
        note = create(:note, user: create(:random_user), priority: create(:priority))
        delete :destroy, params: { id: note.id }
      end

      it 'should return status code 200.' do
        expect(response).to have_http_status(200)
      end
      it "should return a hash with deleted notes attributes." do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:title]).to eq('foo')
      end
    end
    context 'when params are invalid.' do

      before do
        delete :destroy, params: { id: 1000 }
      end

      it 'should return error message.' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:message]).to eq('Note not found.')
      end
      it 'should return status 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
