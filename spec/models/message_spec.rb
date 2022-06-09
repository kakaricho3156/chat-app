require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'contentとimageが存在していれば保存できる' do
        expect(@message).to be_valid
      end
      it 'contentが空でも保存できる' do
        @message.content=""
        expect(@message).to be_valid
      end
      it 'imageが空でも保存できる' do
        @message.image=nil
        expect(@message).to be_valid

      end
    end
    context 'メッセージが投稿できない場合' do
      it 'contentとimageが空では保存できない' do
        @message.content=""
        @message.image=nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'roomが紐付いていないと保存できない' do
        @message.room=nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Room must exist")
      end
      it 'userが紐付いていないと保存できない' do
        @message.user=nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end

      it 'ログインに失敗し、再びサインインページに戻ってくる' do
        # 予め、ユーザーをDBに保存する
        @user = FactoryBot.create(:user)
        # トップページに遷移する
        visit root_path
        # ログインしていない場合、サインインページに遷移していることを確認する
        expect(current_path).to eq(new_user_session_path)
        # 誤ったユーザー情報を入力する
        fill_in "user_email",with:"test"
        fill_in "user_password",with:"test"
        # ログインボタンをクリックする
        click_on ("Log in")
        # サインインページに戻ってきていることを確認する
        expect(current_path).to eq(new_user_session_path)
      end
    end  
    end
  end
end

