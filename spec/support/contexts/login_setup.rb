RSpec.shared_context 'login setup' do
  User.destroy_all
  let(:login_user) { create(:user, password: "Password1234!") }
  let(:login_headers) do
    post "/login", params: { user: { email: login_user.email, password: "Password1234!" } }
    token = body[:token]
    { "ACCEPT" => "application/json", "Authorization" => "Bearer #{token}" }
  end
end
