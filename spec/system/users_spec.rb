require 'rails_helper'

RSpec.describe 'User新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'トップページから正常に動く場合' do
    it 'ログイン、ログアウト、新規登録ができる場合' do
      # ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示される
      # トップページへ移動
      visit root_path
      # トップページに新規登録ボタンやログインボタンがある
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')

      # ヘッダーの新規登録/ログインボタンをクリックすることで、各ページに遷移できる
      # 新規登録ボタンをクリックし、新規登録ページへ移動する
      click_link '新規登録'
      # トップページに戻る
      visit root_path
      # ログインボタンを押し、ログインページへ移動する
      click_link 'ログイン'

      # ユーザーの新規登録ができる
      # 新規登録画面へ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      sign_up(@user)
      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)

      # ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示される
      # ヘッダーにユーザーのニックネームやログアウトボタンが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

      # ヘッダーのログアウトボタンをクリックすることで、ログアウトができる
      # ログアウトボタンをクリック
      click_link 'ログアウト'
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにユーザーのニックネームやログアウトボタンがないことを確認する
      expect(page).to have_no_content(@user.nickname)
      expect(page).to have_no_content('ログアウト')

      # ログインができる
      sign_in(@user)
    end
  end

  describe "トップページから新規登録やログインができない場合" do
    context "新規登録できない時" do
      it "空欄ではユーザー新規登録ができずにエラーが出る" do
        # トップページから新規登録ページへ移動
        visit root_path
        expect(page).to have_content('新規登録')
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'nickname', with: ""
        fill_in 'email', with: ""
        fill_in 'password', with: ""
        fill_in 'password-confirmation', with: ""
        fill_in 'last-name', with: ""
        fill_in 'first-name', with: ""
        fill_in 'last-name-kana', with: ""
        fill_in 'first-name-kana', with: ""
        select "--", from: 'user_birthday_1i'
        select "--", from: 'user_birthday_2i'
        select "--", from: 'user_birthday_3i'
        # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/users')
      end

      it "誤った情報ではユーザー新規登録ができずにエラーが出る" do
        # トップページから新規登録ページへ移動
        visit root_path
        expect(page).to have_content('新規登録')
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'nickname', with: "a"
        fill_in 'email', with: "aaa@aaa"
        fill_in 'password', with: "1234"
        fill_in 'password-confirmation', with: "2234"
        fill_in 'last-name', with: "SATO"
        fill_in 'first-name', with: "HIRO"
        fill_in 'last-name-kana', with: "佐藤"
        fill_in 'first-name-kana', with: "広"
        select "1970", from: 'user_birthday_1i'
        select "12", from: 'user_birthday_2i'
        select "--", from: 'user_birthday_3i'
        # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/users')
      end

      it "メールアドレスに＠が含まれていないと登録ボタンを押しても実行されない" do
        # トップページから新規登録ページへ移動
        visit root_path
        expect(page).to have_content('新規登録')
        visit new_user_registration_path
        # ユーザー情報を入力する
        @user.email = "aaa-aaa"
        sign_up(@user)
        # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 新規登録ページから動かないことを確認する
        expect(current_path).to eq('/users/sign_up')
      end
    end

    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        @user = FactoryBot.create(:user)
        # トップページからログインページへ移動
        visit root_path
        expect(page).to have_content('ログイン')
        visit user_session_path
        # ユーザー情報を入力する
        fill_in 'email', with: "aaa@a"
        fill_in 'password', with: "1234"
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページに戻ることを確認
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end
