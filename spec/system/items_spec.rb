require 'rails_helper'

RSpec.describe "商品投稿機能", type: :system do
  before do
    @item = FactoryBot.create(:item)
  end

  describe 'ログインしたユーザーは商品の新規投稿できる' do
    context '商品の新規投稿に成功したとき' do
      it '商品の新規投稿に成功すると、トップページに遷移して、投稿した内容が表示されている' do
        # サインインして新規投稿画面に移動
        sign_in(@item.user)
        visit new_item_path
        # 値を各フォームに入力する
        item_new(@item)
        # JavaScriptで手数料と利益が正しく表示されている
        price_fees = (@item.price * 0.1).round
        sales_profit = @item.price - price_fees
        expect(page).to have_content(price_fees)
        expect(page).to have_content(sales_profit)
        # 送信した値がDBに保存されていることを確認する
        expect {
          find('input[name="commit"]').click
        }.to change { Item.count }.by(1)
        # 投稿一覧画面に遷移していることを確認する(root_pathだと、URLに渡された値の都合でエラーになる)
        expect(current_path).to eq(items_path)
        # 送信した値がブラウザに表示されていることを確認する
        expect(page).to have_selector('img[src$="test_image.jpg"]')
        expect(page).to have_content(@item.item_name)
        expect(page).to have_content(@item.price)
      end
    end

    context '新規投稿できないとき' do
      it '空欄では商品の新規投稿ができずにエラーが出る' do
        # サインインして新規投稿画面に移動
        sign_in(@item.user)
        visit new_item_path
        # 入力せず出品ボタンを押すとユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Item.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/items')
      end

      it 'priceが300円未満では商品の新規投稿ができずにエラーが出る' do
        # サインインして新規投稿画面に移動
        sign_in(@item.user)
        visit new_item_path
        # 値を各フォームに入力する
        @item.price = 299
        item_new(@item)
        # 出品ボタンを押すとユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Item.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/items')
      end

      it 'priceが9999999円を超える場合は商品の新規投稿ができずにエラーが出る' do
        # サインインして新規投稿画面に移動
        sign_in(@item.user)
        visit new_item_path
        # 値を各フォームに入力する
        @item.price = 10000000
        item_new(@item)
        # 出品ボタンを押すとユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Item.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/items')
      end
    end
  end
end
