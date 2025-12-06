// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Large {
    struct Accessory {
        uint UID;
        uint strength;
    }

    struct TableVector {
        mapping(uint256 => Accessory[]) accessories;
    }

    struct HeroVector {
        uint UID;
        mapping(uint256 => TableVector) tables;
    }


    // Big heroes & vector-table 
    uint public nextHeroBigId;
    mapping(uint256 => HeroVector) heroesBig;

    uint public dummyBig;


    // Three Accessory[] vectors of length 200 for a big hero in table 0
    function _initBigTable(uint heroId) internal {
        HeroVector storage heroVector = heroesBig[heroId];
        TableVector storage tableVector = heroVector.tables[0];

        // slot 0
        for (uint j = 0; j < 20; j++) {
            tableVector.accessories[0].push(Accessory({ UID: j, strength: 0 }));
        }

        // slot 1
        for (uint j = 0; j < 20; j++) {
            tableVector.accessories[1].push(Accessory({ UID: j, strength: 0 }));
        }

        // slot 2
        for (uint j = 0; j < 20; j++) {
            tableVector.accessories[2].push(Accessory({ UID: j, strength: 0 }));
        }
    }

    // big hero with vector

    // create_table_dynamicField_with_vector in Move
    function createBigHeroes() external {
        for (uint i = 0; i < 5; i++) {
            uint heroId = ++nextHeroBigId;
            heroesBig[heroId].UID = heroId;
            _initBigTable(heroId);
        }
    }

    // access_table_dynamicField_with_vector in Move
    function accessBigHeroes() external {
        require(nextHeroBigId >= 1, "No big heroes created");
        uint heroId = 1;

        HeroVector storage heroVector = heroesBig[heroId];
        TableVector storage tableVector = heroVector.tables[0];

        require(tableVector.accessories[0].length >= 1, "Vectors not initialized");

        uint localSum = 0;
        for (uint i = 0; i < 1000; i++) {
            Accessory storage sword = tableVector.accessories[0][0];
            Accessory storage shield = tableVector.accessories[1][0];
            Accessory storage hat = tableVector.accessories[2][0];

            localSum += sword.UID + shield.UID + hat.UID;
        }

        dummyBig = localSum;
    }

    // update_table_dynamicField_with_vector in Move
    function updateBigHeroes() external {
        require(nextHeroBigId >= 1, "No big heroes created");
        uint heroId = 1;

        HeroVector storage heroVector = heroesBig[heroId];
        TableVector storage tableVector = heroVector.tables[0];
        require(tableVector.accessories[0].length >= 1, "Vectors not initialized");

        for (uint i = 0; i < 1000; i++) {
            tableVector.accessories[0][0].strength += 1;
            tableVector.accessories[1][0].strength += 1;
            tableVector.accessories[2][0].strength += 1;
        }
    }

    // delete_table_dynamicField_with_vector in Move
    function deleteOneBigHero() external {
        require(nextHeroBigId >= 1, "No big heroes created");
        uint heroId = 1;

        HeroVector storage heroVector = heroesBig[heroId];
        delete heroVector.tables[0];
        delete heroesBig[heroId];
    }
}
