const Token = artifacts.require("Dog");

contract("Dog", function(accounts) {

  const OWNER = accounts[0];
  const ALICE = accounts[1];
  const BOB = accounts[2];

  let contractInstance;
  
  describe('Contract with zero AUD', () => {

    beforeEach(async () => ( contractInstance = await Token.new(0) ));
    
    it("should add new dog", async function () {
      await contractInstance.add("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.totalSupply();
      assert.equal(Number(actual), 1, "Total supply should be 1");
    });
  
    // it("owner balance should be 0", async function () {
    //   const actual = await contractInstance.balanceOf(OWNER);
    //   assert.equal(Number(actual), 0, "Balance should be 0");
    // });
  
    // it("should mint 2000 tokens", async function () {
    //   await contractInstance.mint(2000);
    //   const balance = await contractInstance.balanceOf(OWNER);
    //   assert.equal(Number(balance), 2000, "Balance should be 2000");
    // });
  });
});