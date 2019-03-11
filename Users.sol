pragma  solidity^0.4.19;
contract Users{
  struct User{
    string  name;
    uint iat;
    uint exp;
    uint index;
    bytes32 ASQ;
    bytes32 myASQ;
    uint Rpt;
  }
  address owner;
  uint public Rpt=60;
  // Initialized reputation value
  uint numUsers;
  mapping (uint => User) users;
  mapping (uint => bytes)asqs;//the answers of secuerity question
  modifier ownerOnly(){
    require(msg.sender==owner);
    _;
  }
  event Userinfo(uint userID,bytes32 myASQ,address owner);
  function newUser(string name,uint iat,uint exp ,uint index,bytes32 ASQ,bytes32 myASQ)public returns(uint userID){
    userID=numUsers++;
    users[userID]=User(name,iat,exp,index,ASQ,myASQ,60);
  }
  function compareASQ (bytes a, bytes b ) public  returns (bool){
       if(keccak256(a) == keccak256(b)){
           Rpt++;
           return true;
       }
       else{
           Rpt--;
           return false;
       }

   }
   function UserRPT(uint userID)public returns(uint ){
       User storage c=users[userID];
       c.Rpt=Rpt;
       return Rpt;

   }
  function kill()public{
    if(msg.sender==owner){
      selfdestruct(owner);
    }
  }
}
