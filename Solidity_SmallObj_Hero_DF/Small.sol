// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Small {
    struct Accessory {
        uint UID;
        uint strength;
    }

    struct Table {
        mapping(uint256 => Accessory) accessories;
    }

    struct Hero {
        uint UID;
        mapping(uint256 => Table) tables;
    }


    // Small heroes & accessory-table
    uint public nextHeroSmallId;
    mapping(uint256 => Hero) heroesSmall;

    uint public dummySmall;

    // sword/shield/hat for a small hero 
    function _initSmallTable(uint heroId) internal {
        Hero storage hero = heroesSmall[heroId];
        Table storage table = hero.tables[0];

        table.accessories[0] = Accessory({ UID: 0, strength: 0 }); // sword
        table.accessories[1] = Accessory({ UID: 1, strength: 0 }); // shield
        table.accessories[2] = Accessory({ UID: 2, strength: 0 }); // hat
    }

    // small hero no vector

    // create_table_dynamicField in Move
    function createSmallHeroes() external {
        for (uint i = 0; i < 10; i++) {
            uint heroId = ++nextHeroSmallId;
            heroesSmall[heroId].UID = heroId;
            _initSmallTable(heroId);
        }
    }

    //  access_table_dynamicField in Move
    function accessSmallHeroes() external {
        require(nextHeroSmallId >= 1, "No small heroes created");
        uint heroId = 1;

        Hero storage hero = heroesSmall[heroId];
        Table storage table = hero.tables[0];

        uint localSum = 0;
        for (uint i = 0; i < 1000; i++) {
            Accessory storage sword  = table.accessories[0];
            Accessory storage shield = table.accessories[1];
            Accessory storage hat    = table.accessories[2];

            localSum += sword.strength;
            localSum += shield.strength;
            localSum += hat.strength;
        }
        dummySmall = localSum;
    }

    // update_table_dynamicField in Move
    function updateSmallHeroes() external {
        require(nextHeroSmallId >= 1, "No small heroes created");
        uint heroId = 1;

        Hero storage hero = heroesSmall[heroId];
        Table storage table = hero.tables[0];

        for (uint i = 0; i < 1000; i++) {
            table.accessories[0].strength += 1;
            table.accessories[1].strength += 1;
            table.accessories[2].strength += 1;
        }
    }

    // delete_table_dynamicField_detachAndDeleteAccessories in Move
    function deleteOneSmallHero() external {
        require(nextHeroSmallId >= 1, "No small heroes created");
        uint heroId = 1;

        Hero storage hero = heroesSmall[heroId];
        delete hero.tables[0];
        delete heroesSmall[heroId];
    }
}
