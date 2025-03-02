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

  # TODO ログイン状態の切り出し

  describe "PUT /users/'id" do
    let!(:user2) { create(:user, email: "example2@example.com", password: "Password1234!") }

    it 'ユーザーを更新できる' do
      # login処理
      post "/login", params: { user: {  email: "example2@example.com", password: "Password1234!" } }
      token = body["token"]
      # Content-TypeではなくACCEPTを使用するとas: :jsonが不要になる
      headers = { "ACCEPT" => "application/json", "Authorization" => "Bearer #{token}" }

      # 更新処理
      put "/users/#{user2.id}",
        params: { user: { email: "updated@gmail.com", password: "Password1234!" } },
        headers: headers

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
