require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /todos" do
    context 'ログインしているとき' do
      include_context 'login setup'
      let!(:todo) { create(:todo, user: login_user) }

      before { get '/todos', headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'todo一覧を取得できる' do
        expect(body[:todos].size).to eq(1)
      end

      it 'todoの所有者はログインユーザーである' do
        expect(body[:todos].first[:user_id]).to eq(login_user.id)
      end
    end

    context 'ログインしていないとき' do
      before { get '/todos' }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end

  describe "GET /todos/:id" do
    context 'ログインしているとき' do
      include_context 'login setup'
      let!(:todo) { create(:todo, user: login_user) }

      before { get "/todos/#{todo.id}", headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'todoを取得できる' do
        expect(body[:todo][:id]).to eq(todo.id)
      end

      it 'todoの所有者はログインユーザーである' do
        expect(body[:todo][:user_id]).to eq(login_user.id)
      end
    end

    context 'ログインしていないとき' do
      before { get "/todos/1" }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end


  describe "POST /todos" do
    context 'ログインしているとき' do
      include_context 'login setup'

      before { post '/todos', params: { todo: { title: 'test', content: 'test' } }, headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it '作成したtodoが返される' do
        expect(body[:todo][:title]).to eq('test')
        expect(body[:todo][:content]).to eq('test')
      end

      it 'todoの合計数が1つ増えている' do
        expect(login_user.todos.count).to eq(1)
      end
    end

    context 'ログインしていないとき' do
      before { post '/todos', params: { todo: { title: 'test', content: 'test' } } }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end

  describe "PATCH /todos/:id" do
    context 'ログインしているとき' do
      include_context 'login setup'
      let!(:todo) { create(:todo, user: login_user) }

      before { patch "/todos/#{todo.id}", headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'アーカイブされている' do
        expect(body[:todo][:is_completed]).to eq(true)
      end
    end

    context 'ログインしていないとき' do
      before { patch "/todos/1" }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end

  describe "DELETE /todos/:id" do
    context 'ログインしているとき' do
      include_context 'login setup'
      let!(:todo) { create(:todo, user: login_user) }

      before { delete "/todos/#{todo.id}", headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'todoの合計数が1つ減っている' do
        expect(login_user.todos.count).to eq(0)
      end
    end

    context 'ログインしていないとき' do
      before { delete "/todos/1" }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end
end
