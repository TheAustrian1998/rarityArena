//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract RarityArena is Ownable {
    constructor() {}

    //Requirements to enter
    uint public goldGlobalRequirement;
    uint public craftGlobalRequirement;
    uint public goldDeathMatchRequirement;

    //Loot (what you receives for winning in %)
    uint public goldGlobalLoot;
    uint public goldDeathMatchLoot;

    //Locked time in ArenaHealthCare (in hours)
    uint public lockTimeDeathMatch;

    //mappings
    mapping(uint => Fight) fights;
    mapping(uint => Arena) arenas;
    mapping(uint => SummonerStatus) summonerStatus;

    enum ArenaType {
        None,
        MatchMaker,
        NoRules,
        DeathMatch,
        TeamFight,
        EventFight
    }

    enum Status {
        Default,
        InQueue,
        InMatch,
        InArenaHealthCare
    }

    struct Fight {
        uint FightId;
        uint ArenaId;
    }

    struct Arena {
        uint ArenaId;
        ArenaType Type;
    }

    struct SummonerStatus {
        uint summonerId;
    }

    function getFight(uint FightId) public view returns (Fight memory) {
        return fights[FightId];
    }

    function nextArena() public view {}

    function getSummonerStatus() public view {}

    function arenaStats() public view {}

    function enterArena() external {}

    function addFight() external onlyOwner {}

    function updateArenaRequirements() external onlyOwner {}
}
