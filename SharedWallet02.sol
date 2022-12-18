pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet02  is Ownable {
    mapping (address => uint) public members; // создаем "базу" участников, в кот. участник будет записан как адрес и он будет искаться по лимиту, те лимит может меняться, а участник - нет. 
    
    function isOwner() internal view returns(bool) {
    return owner() == _msgSender();
  }

   modifier ownerOrWithinLimits (uint _amount){
      require (isOwner()||  members[_msgSender()] >= _amount, "Something went wrong!" );
      _;
   }

    function addLimit (address _member, uint _limit) public onlyOwner { //добавить нового участника и его лимит, вызвать ее может только инициатор транзакции
        members[_member] = _limit; //задаем формат как добавить
    }

    function deduceFromLimit (address _member, uint _amount) internal { //обновить значение баланса после вывода
       members[_member] -= _amount;
    }

     function renounceOwnership() override public view onlyOwner { //отключаем не нужную фукцию из Owner.sol 
    revert("Can't renounce!");
  }
}
