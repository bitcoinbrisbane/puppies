const Token = artifacts.require("DogERC721Metadata");

contract("DogERC721Metadata", function(accounts) {

  const OWNER = accounts[0];
  const ALICE = accounts[1];
  const BOB = accounts[2];

  let contractInstance;
  
  describe('Dog functions', () => {

    beforeEach(async () => ( contractInstance = await Token.new("Beagles", "DDA") ));
    
    it("should add new dog", async function () {
      await contractInstance.addPuppy("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.totalSupply();
      assert.equal(Number(actual), 1, "Total supply should be 1");
    });
  
    it("should get balance of to be 1", async function () {
      await contractInstance.addPuppy("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.balanceOf(ALICE);
      assert.equal(Number(actual), 1, "Balance should be 1");
    });

    it("should get owner of", async function () {
      await contractInstance.addPuppy("Forrest", 0, "CHIP1", 0, 0, 0, ALICE);

      const actual = await contractInstance.ownerOf(0);
      assert.equal(actual, ALICE, "Owner should be Alice");
    });

    it("should set fee", async function () {
      await contractInstance.setFee(1);

      const actual = await contractInstance.fee();
      assert.equal(actual, 1, "Fee should be 1");
    });
  });
});