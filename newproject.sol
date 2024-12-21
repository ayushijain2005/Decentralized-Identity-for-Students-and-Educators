// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedIdentity {

    // Structure to hold user details
    struct User {
        string name;
        string role; // Student or Educator
        string institution;
        uint256 joinDate;
    }

    // Mapping of address to User details
    mapping(address => User) public users;

    // Event to log user registration
    event UserRegistered(address indexed userAddress, string name, string role, string institution);

    // Function to register a new user
    function registerUser(string memory _name, string memory _role, string memory _institution) public {
        require(bytes(_name).length > 0, "Name is required");
        require(bytes(_role).length > 0, "Role is required");
        require(bytes(_institution).length > 0, "Institution is required");
        require(keccak256(abi.encodePacked(_role)) == keccak256(abi.encodePacked("Student")) || keccak256(abi.encodePacked(_role)) == keccak256(abi.encodePacked("Educator")), "Role must be Student or Educator");

        users[msg.sender] = User({
            name: _name,
            role: _role,
            institution: _institution,
            joinDate: block.timestamp
        });

        emit UserRegistered(msg.sender, _name, _role, _institution);
    }

    // Function to retrieve user details
    function getUserDetails(address _userAddress) public view returns (string memory, string memory, string memory, uint256) {
        User memory user = users[_userAddress];
        return (user.name, user.role, user.institution, user.joinDate);
    }

    // Function to check if a user is registered
    function isUserRegistered(address _userAddress) public view returns (bool) {
        return bytes(users[_userAddress].name).length > 0;
    }
}
