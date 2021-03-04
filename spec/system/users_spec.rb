require 'rails_helper'

RSpec.describe 'User新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'トップページ' do
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
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
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
      # ログインページへ移動する
      visit user_session_path
      # ログイン情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
    end
  end
end
