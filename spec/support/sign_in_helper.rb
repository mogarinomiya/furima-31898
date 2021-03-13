module SignInHelpers
  def sign_in(user)
    # ログインができる
    # ログインページへ移動する
    visit user_session_path
    # ログイン情報を入力する
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページに遷移したことを確認
    expect(current_path).to eq(root_path)
  end
end