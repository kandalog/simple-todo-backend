require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context '正常系' do
      it 'validationが通る' do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context '異常系' do
      context 'email' do
        it 'emailは必須である' do
          user = build(:user, email: nil)
          expect(user).to be_invalid
          expect(user.errors.full_messages).to include("Email can't be blank")
        end

        it 'emailは正しいフォーマットの必要がある' do
          user = build(:user, email: "invalid_email")
          expect(user).to be_invalid
          expect(user.errors.full_messages).to include("Email emailの形式が間違っています")
        end

        it 'emailは一意な値の必要がある' do
          create(:user, email: "test@example.com")
          user = build(:user, email: "test@example.com")
          expect(user).to be_invalid
          expect(user.errors.full_messages).to include("Email has already been taken")
        end
      end

      context 'password' do
        it 'passwordは必須である' do
          user = build(:user, password: nil)
          expect(user).to be_invalid
          expect(user.errors.full_messages).to include("Password can't be blank")
        end

        it 'passwordは8文字以上で大文字小文字数字記号をそれぞれ1文字以上含む必要がある' do
          user = build(:user, password: nil)
          expect(user).to be_invalid
          expect(user.errors.full_messages).to include("Password パスワードは8桁以上で半角英大文字・小文字・数字・記号をそれぞれ1文字以上含む必要があります")
        end

        it 'passwordとpassword_confirmationは一致する必要がある' do
          user = build(:user, password_confirmation: 'test')
          expect(user).to be_invalid
          expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
    end
  end

  describe '初期値の確認' do
    it 'is_adminはfalseである' do
        # FactoryBotでは明示的にfalseを設定しているため、Modelのデフォルト値を検証する
        user = User.new(email: 'test@example.com', password: 'Password123!')
        expect(user.is_admin).to eq false
    end
  end
end
