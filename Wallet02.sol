pragma solidity >=0.7.0 <0.9.0;
import "./SharedWallet02.sol";

contract Wallet02 is SharedWallet02 {
//    // концепция "владельца"
//     address owner ;

//     constructor () {
//         owner == msg.sender;
//     }
//    // модификатор препятствует копированию кода в одинаковых проверках, это проверка на концепцию "владельца"
//     modifier onlyOwner () {
//       require (msg.sender == owner, "U a not an owner!");
//       _;
//     }
    //зачисление eth на контракт
 function sendToContract() public payable {
    address payable _to = payable(this); // адрес этого контракта
    _to.transfer(msg.value); // отправить на адрес количество eth из транзакции
  }

//узнать текущий баланс     
  function getBalance() public view returns(uint) {
    return address(this).balance;
  }
// вывод eth на адрес инициатора транзакции
  function withdrawMoney (uint _amount) public ownerOrWithinLimits (_amount){
      require (_amount <= address(this).balance, "There is no enouhgt money!"); // проверяем есть ли вообще на контрате денег больше или = чем просят
      address payable _to = payable(msg.sender);//адрес создателя транзакции
      _to.transfer(_amount); // отправить вводимый _amount на адрес
  }
    
  fallback() external payable {}
    
  receive() external payable {}
}
