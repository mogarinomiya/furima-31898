module DateSelectHelpers
  def date_select(date, _options = {})
    year, month, day = date.split('-')

    # 0始まりだとエラー返るので、数値型に直して0とってから文字列型に戻す
    month = month.to_i
    month = month.to_s
    day = day.to_i
    day = day.to_s

    select year, from: 'user_birthday_1i'
    select month, from: 'user_birthday_2i'
    select day, from: 'user_birthday_3i'
  end
end
