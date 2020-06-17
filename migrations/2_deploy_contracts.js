const Almacenamiento = artifacts.require("Almacenamiento");
const Token = artifacts.require("Token");

module.exports = function(deployer) {
  deployer.deploy(Almacenamiento);
  deployer.deploy(Token);
};