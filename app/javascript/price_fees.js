function price_fees (){
  // 入力フォームを取得
  const itemData = document.getElementById("item-price");
  // 入力フォームに値が入力されたら、
  itemData.addEventListener("keyup", () =>{
    // 入力値を取得
    const itemPrice = itemData.value;
    // 販売手数料算出
    const priceFees = Math.round(itemPrice * 0.1);
    // 販売利益算出
    const salesProfit = itemPrice - priceFees;
    // 出力先のID取得
    const percentNum = document.getElementById('add-tax-price');
    const profitNum = document.getElementById('profit')
    // 出力
    percentNum.innerHTML = `${priceFees}`;
    profitNum.innerHTML = `${salesProfit}`
  });
}
window.addEventListener('load', price_fees);