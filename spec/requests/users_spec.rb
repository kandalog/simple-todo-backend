require 'rails_helper'

RSpec.describe "Users", type: :request do
  after { User.destroy_all }

  describe "GET /users" do
    include_context 'admin setup'

    before { get '/users', headers: admin_headers }

    it 'adminはユーザー覧を取得できる' do
      expect(response).to be_successful
      expect(body.size).to eq(1)
    end
  end

  describe "GET /users/:id" do
    include_context 'login setup'

    before { get "/users/#{login_user.id}", headers: login_headers }

    it 'ユーザーを取得できる' do
      expect(response).to be_successful
      expect(body[:user][:id]).to eq(login_user.id)
    end
  end

  describe "POST /users" do
    before { post '/users', params: { user: { email: 'sample@example.com', password: "Password123!" } } }

    it 'ユーザーを作成できる' do
      expect(response).to be_successful
      expect(body[:user][:email]).to eq('sample@example.com')
    end
  end

  describe "PUT /users/'id" do
    include_context 'login setup'

    it 'ユーザーを更新できる' do
      put "/users/#{login_user.id}",
        params: { user: { email: "updated@gmail.com", password: "Password123!" } },
        headers: login_headers

      expect(response).to be_successful
      expect(body[:user][:email]).to eq('updated@gmail.com')
    end
  end

  describe "DELETE /users/:id" do
    include_context 'login setup'

    before { delete "/users/#{login_user.id}", headers: login_headers }

    it 'ユーザーを削除できる' do
      expect(response).to be_successful
      expect(User.count).to eq(0)
    end
  end
end
