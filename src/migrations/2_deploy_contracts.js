const Dog = artifacts.require('DogERC721Metadata');

module.exports = async (deployer) => {
    let instance = await deployer.deploy(Dog, "Test puppies", "Test");
};