// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


import { ISuperHonk } from "./ISuperHonk.sol";

contract Cars {

    enum CarStatus { driving, parked}



    struct Car {
        bytes3 colour;
        uint8 doors;
        CarStatus status;
        address owner;
    }

    ISuperHonk private superHonk;
    uint256 public numCars = 0;
    mapping(uint256 => Car) public cars;

    constructor(
        address superHonkAddress
    ) {
        superHonk = ISuperHonk(superHonkAddress);
    }

    function addCar(
        bytes3 colour,
        uint8 doors
    )
    public 
    payable 
    returns(uint256 carId)
    {
        require(
            msg.value >= 0.01 ether,
            "not enough money bro"
        );
        carId = ++numCars;
        Car memory newCar = Car(
            colour,
            doors,
            CarStatus.parked,
            msg.sender
        );
        cars[carId] = newCar;
    }

    function statusChange(
        uint carId,
        CarStatus newStatus
    )
    public 
    onlyOwner(carId)
    {

        require (
            cars[carId].status != newStatus,
            "no change in status"
        );
        cars[carId].status = newStatus;
    } 

    modifier onlyOwner (
        uint256 carId
    ) {
        require(cars[carId].owner == msg.sender,
            "only owner"
        );
        _;
    }

    function honk (
        uint256 carId, 
        bool isLoud
    ) public 
    onlyOwner(carId)
    {
        if (isLoud) {
            superHonk.honk();
        }
    }
}