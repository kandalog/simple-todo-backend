require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    context 'adminがログインしているとき' do
      include_context 'admin setup'

      before { get '/users', headers: admin_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'ユーザー覧を取得できる' do
        expect(body[:users].size).to eq(1)
      end
    end

    context '一般ユーザーがログインしているとき' do
      include_context 'login setup'

      before { get '/users', headers: login_headers }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('権限がありません')
      end
    end

    context 'ログインしていないとき' do
      before { get '/users' }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end

  describe "GET /users/:id" do
    context "ログインしているとき" do
      include_context 'login setup'

      before { get "/users/#{login_user.id}", headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'ユーザーを取得できる' do
        expect(body[:user][:id]).to eq(login_user.id)
      end
    end

    context "ログインしていないとき" do
      before { get "/users/1" }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end

  describe "POST /users" do
    before { post '/users', params: { user: { email: 'sample@example.com', password: "Password123!" } } }

    it 'statusが200である' do
      expect(response).to be_successful
      expect(body[:user][:email]).to eq('sample@example.com')
    end

    it '作成したuserが返される' do
      expect(body[:user][:email]).to eq('sample@example.com')
    end

    it 'userの合計数が1つ増えている' do
      expect(User.count).to eq(1)
    end
  end

  describe "PUT /users/'id" do
    context 'ログインしているとき' do
      include_context 'login setup'

      before { put "/users/#{login_user.id}", params: { user: { email: "updated@gmail.com", password: "Password123!" } }, headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'ユーザーを更新できる' do
        expect(body[:user][:email]).to eq('updated@gmail.com')
      end
    end

    context 'ログインしていないとき' do
      before { put "/users/1", params: { user: { email: "updated@gmail.com", password: "Password123!" } } }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end

  describe "DELETE /users/:id" do
    context 'ログインしているとき' do
      include_context 'login setup'

      before { delete "/users/#{login_user.id}", headers: login_headers }

      it 'statusが200である' do
        expect(response).to be_successful
      end

      it 'ユーザーの合計数が1つ減っている' do
        expect(User.count).to eq(0)
      end
    end

    context 'ログインしていないとき' do
      before { delete "/users/1" }

      it 'statusが401である' do
        expect(response).to be_unauthorized
      end

      it '適切なメッセージが返る' do
        expect(body[:errors]).to eq('ログインが必要です')
      end
    end
  end
end
