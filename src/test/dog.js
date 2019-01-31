const Token = artifacts.require("DogERC721");

contract("DogERC721", function(accounts) {

  const OWNER = accounts[0];
  const ALICE = accounts[1];
  const BOB = accounts[2];

  let contractInstance;
  
  describe('Dog functions', () => {

    beforeEach(async () => ( contractInstance = await Token.new(0) ));
    
    it("should add new dog", async function () {
      await contractInstance.add("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.totalSupply();
      assert.equal(Number(actual), 1, "Total supply should be 1");
    });
  
    it("should get balance of to be 1", async function () {
      await contractInstance.add("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.balanceOf(ALICE);
      assert.equal(Number(actual), 1, "Balance should be 1");
    });

    it("should exist", async function () {
      await contractInstance.add("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.exists(0);
      assert.isTrue(actual, "Should be true");
    });

    it("should get owner of", async function () {
      await contractInstance.add("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.ownerOf(ALICE);
      assert.equal(actual, ALICE, "Owner should be Alice");
    });
  });
});