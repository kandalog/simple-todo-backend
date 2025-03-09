RSpec.shared_context 'admin setup' do
  User.destroy_all
  let(:admin) { create(:user, password: "Password1234!", is_admin: true) }
  let(:admin_headers) do
    post "/login", params: { user: { email: admin.email, password: "Password1234!" } }
    token = body[:token]
    { "ACCEPT" => "application/json", "Authorization" => "Bearer #{token}" }
  end
end
