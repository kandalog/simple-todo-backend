require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  after { User.destroy_all }

  describe "GET /users" do
    before { get '/users' }

    it 'ユーザー覧を取得できる' do
      expect(response).to be_successful
      expect(body.size).to eq(1)
    end
  end

  describe "GET /users/:id" do
    before { get "/users/#{user.id}" }

    it 'ユーザーを取得できる' do
      expect(response).to be_successful
      pp user.id
      expect(body['id']).to eq(user.id)
    end
  end

  describe "POST /users" do
    before { post '/users', params: { user: { email: 'sample@example.com', password: "Password123!" } } }

    it 'ユーザーを作成できる' do
      expect(response).to be_successful
      expect(body['email']).to eq('sample@example.com')
    end
  end

  describe "PUT /users/'id" do
    include_context 'login setup'

    it 'ユーザーを更新できる' do
      put "/users/#{login_user.id}",
        params: { user: { email: "updated@gmail.com", password: "Password1234!" } },
        headers: login_headers

      expect(response).to be_successful
      expect(body['email']).to eq('updated@gmail.com')
    end
  end

  describe "DELETE /users/:id" do
    before { delete "/users/#{user.id}" }

    it 'ユーザーを削除できる' do
      expect(response).to be_successful
      expect(User.count).to eq(0)
    end
  end
end
