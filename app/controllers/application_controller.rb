class ApplicationController < ActionController::API
  def create_token(user_id)
    token_expiry = 24.hours.from_now.to_i
    payload = { user_id: user_id, exp: token_expiry }
    secret_key = ENV['JWT_SECRET_KEY']

    JWT.encode(payload, secret_key)
  end

  def authenticate
    bearer = request.headers[:authorization]

    if !bearer
      render_unauthorized("ログインが必要です")
    else
      token = bearer.split(" ")[1]
      secret_key = ENV["JWT_SECRET_KEY"]

      begin
        decoded_token = JWT.decode(token, secret_key)
        @current_user = User.find(decoded_token[0]["user_id"])
      rescue JWT::ExpiredSignature
        render_unauthorized("トークンの有効期限が切れています")
      rescue ActiveRecord::RecordNotFound
        render_unauthorized("ユーザーが見つかりません")
      rescue JWT::DecodeError
        render_unauthorized("無効なトークンです")
      end
    end
  end

  def render_unauthorized(message = "Unauthorized")
    render json: { errors: message }, status: :unauthorized
  end
end
