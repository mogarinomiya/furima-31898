require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  describe '商品を新規投稿できる' do
    it 'item_name、description、category_id、condition_id、shipping_cost_id、province_id、shipping_time_id、price、user、imageすべてが正しく入っている' do
      expect(@item).to be_valid
    end
  end

  describe '商品の新規投稿ができないとき' do
    context '空欄のため投稿できない' do
      it 'item_nameが空では投稿できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'imageがなければ投稿できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'descriptionが空では投稿できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'priceが空では投稿できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number")
      end
      it 'userに紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist", "User can't be blank")
      end
    end
    context '異常値のため投稿できない' do
      it 'category_idが1' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'category_idが12以上' do
        @item.category_id = '12'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be less than or equal to 11")
      end
      it 'condition_idが1' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it 'condition_idが8以上' do
        @item.condition_id = '8'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be less than or equal to 7")
      end
      it 'shipping_cost_idが1' do
        @item.shipping_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost must be other than 1")
      end
      it 'shipping_cost_idが4以上' do
        @item.shipping_cost_id = '4'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost must be less than or equal to 3")
      end
      it 'province_idが1' do
        @item.province_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Province must be other than 1")
      end
      it 'province_idが49以上' do
        @item.province_id = '49'
        @item.valid?
        expect(@item.errors.full_messages).to include("Province must be less than or equal to 48")
      end
      it 'shipping_time_idが1' do
        @item.shipping_time_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time must be other than 1")
      end
      it 'shipping_time_idが5以上' do
        @item.shipping_time_id = '5'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time must be less than or equal to 4")
      end
      it 'priceが300円未満' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが9,999,999円以上' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceが半角数字意外' do
        @item.price = '１５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end