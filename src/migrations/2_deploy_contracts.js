const Dog = artifacts.require('DogERC721Metadata');

module.exports = async (deployer) => {
    let statsInstance = await deployer.deploy("Test puppies", "Test");
};