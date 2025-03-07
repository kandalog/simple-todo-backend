class ApplicationController < ActionController::API
  # トークンを作成する
  def create_token(user_id)
    token_expiry = 24.hours.from_now.to_i
    payload = { user_id: user_id, exp: token_expiry }
    secret_key = ENV['JWT_SECRET_KEY']

    JWT.encode(payload, secret_key)
  end

  # 認証が必要なアクションでは、このメソッドを呼び出す
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

  # 管理者権限が必要なアクションでは、このメソッドを呼び出す
  def authenticate_admin
    render_unauthorized unless is_admin?
  end

  # 現在のユーザーが管理者かどうかを確認する
  def is_admin?
    @current_user.is_admin
  end

  # 現在のユーザーが指定されたユーザーかどうかを確認する
  def current_user?(user)
    @current_user||=authenticate == user
  end

  # 現在のユーザーか管理者かどうかを確認する
  def is_current_user_or_admin?(user)
    current_user?(user) || is_admin?
  end

  # 認証エラー時のレスポンスを返す
  def render_unauthorized(message = "権限がありません")
    render json: { errors: message }, status: :unauthorized
  end
end
