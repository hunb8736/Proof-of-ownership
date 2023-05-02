pragma solidity ^0.8.0;

contract AssetOwnership {
    struct Asset {
        address owner;
        string name;
        // add more properties as needed
    }

    mapping (uint256 => Asset) private assets;

    event AssetCreated(uint256 id, address owner);
    event AssetTransferred(uint256 id, address oldOwner, address newOwner);

    function createAsset(uint256 id, string memory name) public {
        require(assets[id].owner == address(0), "Asset already exists");
        assets[id] = Asset(msg.sender, name);
        emit AssetCreated(id, msg.sender);
    }
    function transferAsset(uint256 id, address newOwner) public {
        require(assets[id].owner == msg.sender, "Only asset owner can transfer ownership");
        assets[id].owner = newOwner;
        emit AssetTransferred(id, msg.sender, newOwner);
    }
    function getAssetOwner(uint256 id) public view returns (address) {
        return assets[id].owner;
    }
}
