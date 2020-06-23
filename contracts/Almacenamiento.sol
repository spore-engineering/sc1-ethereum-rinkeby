//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

contract Almacenamiento {

    struct Nota {
        string detalle;
    }

    mapping(address => Nota[]) public notas;

    address payable jefazo;
    address payable contrato;

    constructor() public payable {
        jefazo = payable(msg.sender);
        contrato = payable(address(this));
    }

    event Received(address, uint);

    modifier isOwner() {
        require(msg.sender == jefazo, "No eres el jefazo");
        _;
    }

    modifier isEnough() {
        require(msg.value >= 0.25 ether, "No alcanza: 0.25 ETH");
        _;
    }
    
    function escribirNota(string memory _nota, address _owner) public payable isEnough {
        contrato.transfer(msg.value);
        notas[_owner].push(Nota({detalle: _nota}));
    }

    function transferirFondos() public payable isOwner {
        jefazo.transfer(contrato.balance);
        emit Received(jefazo, contrato.balance);
    }

    function leerNotas(address _owner) public view returns (Nota[] memory){
        return notas[_owner];
    }

    function totalNotas(address _owner) public view returns(uint) {
        return notas[_owner].length;
    }

    function totalMonto() public view returns(uint) {
        return contrato.balance;
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

}