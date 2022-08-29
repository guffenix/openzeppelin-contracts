//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// ERC20 is not necessary
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

// Also you can use ERC20Pausable
// import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract GoldenToken is Ownable, ERC20Burnable, Pausable, ERC165 {
    constructor() ERC20Burnable() ERC20("GoldenToken", "GLDTK") {
        _mint(msg.sender, 100_000);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC165)
        returns (bool)
    {
        return
            interfaceId == type(IERC20).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function burnAmount(uint256 amount) public {
        require(paused() != true, "This contract is paused");
        _burn(msg.sender, amount);
    }

    function initPauseContract() public onlyOwner {
        _pause();
    }

    function endPauseContract() public onlyOwner {
        _unpause();
    }
}
