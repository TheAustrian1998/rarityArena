//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RarityArena is Ownable {
    using Counters for Counters.Counter;

    constructor() {}

    //Requirements to enter
    uint256 public goldGlobalRequirement;
    uint256 public craftGlobalRequirement;
    uint256 public goldDeathMatchRequirement;

    //Loot (what you receives for winning in %)
    uint256 public goldGlobalLoot;
    uint256 public goldDeathMatchLoot;

    //Locked time in ArenaHealthCare (in hours)
    uint256 public lockTimeDeathMatch;

    //mappings
    mapping(uint256 => Arena) public arenas;
    mapping(uint256 => SummonerStatus) public summonerStatus;

    //
    Counters.Counter public ArenaIdCounter;

    enum ArenaType {
        None,
        MatchMaker,
        NoRules,
        DeathMatch,
        TeamArena,
        EventArena
    }

    enum Status {
        Default,
        InQueue,
        InMatch,
        InArenaHealthCare
    }

    struct Arena {
        uint256 ArenaId;
        ArenaType Type;
        bool IsRunning;
    }

    struct SummonerStatus {
        uint256 SummonerId;
        bool InArena;
    }

    function _enterMatchMaker(uint256 ArenaId, uint256 summonerId) internal {}

    function _enterNoRules(uint256 ArenaId, uint256 summonerId) internal {}

    function _enterDeathMatch(uint256 ArenaId, uint256 summonerId) internal {}

    function _enterTeamArena(uint256 ArenaId, uint256 summonerId) internal {}

    function _enterEventArena(uint256 ArenaId, uint256 summonerId) internal {}

    //Returns next arenaId
    function nextArena() public view returns (uint256) {
        return ArenaIdCounter.current();
    }

    //Router
    function enterArena(uint256 arenaId, uint256 summonerId) external {
        Arena memory arena = arenas[arenaId];
        SummonerStatus memory summoner = summonerStatus[summonerId];
        require(!summoner.InArena, "summoner is in arena");
        require(!arena.IsRunning, "arena is running");

        //Is MatchMaker
        if (arena.Type == ArenaType.MatchMaker) {
            _enterMatchMaker(arenaId, summonerId);
        }

        //Is NoRules
        if (arena.Type == ArenaType.NoRules) {
            _enterNoRules(arenaId, summonerId);
        }

        //Is DeathMatch
        if (arena.Type == ArenaType.DeathMatch) {
            _enterDeathMatch(arenaId, summonerId);
        }

        //Is TeamArena
        if (arena.Type == ArenaType.TeamArena) {
            _enterTeamArena(arenaId, summonerId);
        }

        //Is EventArena
        if (arena.Type == ArenaType.EventArena) {
            _enterEventArena(arenaId, summonerId);
        }

        //Is None (Not valid)
        if (arena.Type == ArenaType.None) {
            revert("not valid arena");
        }

        summoner.InArena = true;
        summonerStatus[summonerId] = summoner;
    }

    function addArena() external onlyOwner {}

    function updateArenaRequirements() external onlyOwner {}
}
