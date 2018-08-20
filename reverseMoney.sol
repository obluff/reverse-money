a solidity ^0.4.19;

contract ReverseMoney {

    address owner;
    uint _totalSupply = 25000;
    
    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowed;
    mapping (address => mapping(address => uint)) history;
    
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
    
    string public name = "Reverse Money";
    string public symbol = "rmn";
    uint8 public decimals = 18;
    
    function ReverseMoney() public {
        owner = msg.sender;
        balances[owner] = 25000;
    }
    
    function totalSupply() public constant returns (uint256 tSupply) {
        return _totalSupply;
     }
    
    function balanceOf(address _owner) public constant returns (uint) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint _amount) public returns (bool success) {
        if (balances[msg.sender] >= _amount
            && _amount > 0
            && balances[_to] + _amount > balances[_to]) {
                _totalSupply += 2 * _amount;
                balances[msg.sender] += 2 * _amount;
                balances[_to] += _amount;
                Transfer(msg.sender, _to, _amount);
                return true;
        }
        else {
            return false;
        }
    }
    
    function transferFrom(address _from, address _to, uint _amount) public returns (bool success) {
        if (balances[_from] >= _amount
            && allowed[_from][msg.sender] >= _amount
            && _amount > 0
            && balances[_to] + _amount > balances[_to]
            && (now - history[_from][_to] >= 1 minutes) && (now - history[_to][_from] >= 1 minutes) || (history[_from][_to] == 0)) {
            history[_from][_to] = now;
            history[_to][_from] = now;
            _totalSupply += _amount;
            balances[_from] += _amount;
            balances[_to] += _amount;
            Transfer(_from, _to, _amount);
            return true;
        }
        else {
            return false;
        }
    }
    
    function approve(address _spender, uint _amount) public returns (bool success) {
        allowed[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount);
        return true;
    }
    
    
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
     }
}
