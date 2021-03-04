require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録／総合' do
    context '新規登録ができるとき' do
      it 'nickname、email、password、password_confirmation、first_name、last_name、first_name_read、last_name_read、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録ができるとき' do
      it 'nicknameが存在すれば登録できる' do
        @user.nickname = 'sara'
        expect(@user).to be_valid
      end
      it '@が入っており、重複していないemailが存在すれば登録できる' do
        @user.email = 'sara@gozira-mail.com'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上、半角英数混合であれば登録できる' do
        PW_OK = '00000a'
        @user.password = PW_OK
        @user.password_confirmation = PW_OK
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'aaaalsa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        PW_NG_5 = '1234a'
        @user.password = PW_NG_5
        @user.password_confirmation = PW_NG_5
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが存在してもpassword_confirmationが空では（相違していては）登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordがアルファベットのみでは登録できない' do
        PW_NG_ABC = 'abcdef'
        @user.password = PW_NG_ABC
        @user.password_confirmation = PW_NG_ABC
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが数字のみでは登録できない' do
        PW_NG_123 = '123456'
        @user.password = PW_NG_123
        @user.password_confirmation = PW_NG_123
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
    end
  end

  describe '新規登録/本人情報確認' do
    context '新規登録できる場合' do
      it 'first_nameとlast_nameが全角ひらがな・カタカナ・漢字で存在すれば登録できる' do
        @user.last_name = '真壁'
        @user.first_name = 'さら'
        expect(@user).to be_valid
      end
      it 'first_name_readとlast_name_readが全角カタカナで存在すれば登録できる' do
        @user.last_name_read = 'マカベ'
        @user.first_name_read = 'サラ'
        expect(@user).to be_valid
      end
      it 'birthdayが生年月日すべて欠けずに存在すれば登録できる' do
        @user.birthday = '1996-09-12'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'ユーザー本名（名字）が空欄では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end
      it 'ユーザー本名（名字）が全角ひらがな・カタカナ・漢字以外では登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'ユーザー本名（名前）が空欄では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it 'ユーザー本名（名前）が全角ひらがな・カタカナ・漢字以外では登録できない' do
        @user.first_name = 'yuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'ユーザー本名（名字・読み）が空欄では登録できない' do
        @user.last_name_read = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name read can't be blank", 'Last name read is invalid')
      end
      it 'ユーザー本名（名字・読み）が全角カタカナ以外では登録できない' do
        @user.last_name_read = 'せがわ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name read is invalid')
      end
      it 'ユーザー本名（名前・読み）が全角カタカナ以外は登録できない' do
        @user.first_name_read = '春菜'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name read is invalid')
      end
      it '生年月日のいずれかあるいはすべてが空欄では登録できない' do
        @user.birthday = '1981-12'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
