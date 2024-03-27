// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* Problem 1 Interface & Contract */
contract StudentV1 {
    // Note: You can declare some state variable
    uint8 count = 1;

    function register() external returns (uint256) {
        // TODO: please add your implementaiton here
        if (count == 1) {
            count = 0;
            return 1000;
        }
        else{
            count == 1;
            return 123;
        }
    }
}

/* Problem 2 Interface & Contract */
interface IClassroomV2 {
    function isEnrolled() external view returns (bool);
}

contract StudentV2 {
    function register() external view returns (uint256) {
        // TODO: please add your implementaiton here
        IClassroomV2 class2 = IClassroomV2(msg.sender);
        if (class2.isEnrolled() == true){
            return 123;
        }
        else{
            return 1000;
        }
    }
}

/* Problem 3 Interface & Contract */
contract StudentV3 {
    function register() external view returns (uint256) {
        // TODO: please add your implementaiton here
        if (gasleft() >= 7000){
            return 1000;
        }
        else{
            return 123;
        }
    }
}
