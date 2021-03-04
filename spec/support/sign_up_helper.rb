module SignUpHelpers
  def sign_up(user)
    # ユーザー情報を入力する
    fill_in 'nickname', with: user.nickname
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password-confirmation', with: user.password_confirmation
    fill_in 'last-name', with: user.last_name
    fill_in 'first-name', with: user.first_name
    fill_in 'last-name-kana', with: user.last_name_read
    fill_in 'first-name-kana', with: user.first_name_read
    date_select(user.birthday.strftime('%Y-%m-%d')) # なぜかここで書式指定しないと「Tue, 21 Jul 1987」になる。@userだけならspec/factories/user.rb内の指定でいけるが、@user.birthdayだとここで再指定が必要。
  end
end