pragma solidity ^0.4.19;
contract Csps{
  struct CSP{
    uint index;
    uint myRpt;
    bytes32 keys;
    bytes32 enJwt;
    bytes32 myhash;
  }
  address owner;
  mapping (uint => CSP)csps;
  uint numCsps;
  uint cspsRpt=60;
  event eventInfo(uint cspID,bytes32 keys,bytes32 enJwt,bytes32 myhash,uint Rpt);
  modifier ownerOnly(){
    require(msg.sender==owner);
    _;
  }
function newCsp(uint index,uint myRpt,bytes32 keys,bytes32 enJwt,bytes32 myhash)public returns(uint cspID){
    cspID=numCsps++;
    csps[cspID]=CSP(index,myRpt,keys,enJwt,myhash);
  }
function getEnjwt(uint cspID)public constant  returns(bytes32){
  CSP storage c = csps[cspID];
  return c.enJwt;
}
function getkeys(uint cspID)public constant returns(bytes32){
    CSP storage d=csps[cspID];
    return d.keys;
}
function getmyhash(uint cspID)public constant returns(bytes32){
    CSP storage e=csps[cspID];
    return e.myhash;
}
function comparehashs(uint cspID,bytes a,bytes b)public  returns(bool){
 CSP storage f=csps[cspID];
  if(keccak256(a) == keccak256(b)){
      f.myRpt++;
      return true;
  }
  else{
      f.myRpt--;
      return false;
  }
}
function kill()public{
    if(msg.sender==owner){
      selfdestruct(owner);
    }
}
}
contract signature{
    uint public Rpt=60;
    function updatemyRpt(address addr)public view returns(uint){
        bytes4 methodId=bytes4(keccak256("comparehashs(bool)"));
        if(addr.delegatecall(methodId, 3))
        {
            return Rpt;
        }
    }


}
