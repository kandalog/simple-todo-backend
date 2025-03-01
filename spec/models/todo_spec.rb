require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'バリデーション' do
    context '正常系' do
      it '投稿を作成できる' do
        todo = build(:todo)
        expect(todo).to be_valid
      end
    end

    context '異常系' do
      it 'titleが空の場合は無効' do
        todo = build(:todo, title: nil)
        expect(todo).to be_invalid
        expect(todo.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空の場合は無効' do
        todo = build(:todo, content: nil)
        expect(todo).to be_invalid
        expect(todo.errors.full_messages).to include("Content can't be blank")
      end

      it '関連するユーザーが存在しない場合は無効' do
        todo = build(:todo, user: nil)
        expect(todo).to be_invalid
        expect(todo.errors.full_messages).to include("User must exist")
      end
    end
  end
end
