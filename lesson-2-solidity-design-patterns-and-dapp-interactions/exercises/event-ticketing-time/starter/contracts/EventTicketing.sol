// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract EventTicketing {
    struct Ticket {
        string attendeeName;
        uint ticketId;
        bool isUsed;
        uint timestamp;
        // TODO: Add timestamp to track when the ticket was purchased
    }

    string public eventName;
    uint public totalTicketsSold;
    uint public maxTickets;
    uint public startTime;
    uint public endTime;
    mapping(uint => Ticket) public ticketsSold;
    event TicketPurchased(uint ticketId, string attendeeName, uint timestamp);

    // TODO: Add start and end times variables for ticket sales

    // TODO: Initialize a constructor with start and end times for ticket sales
    constructor(uint _startTime, uint _endTime){
        require(_startTime > _endTime, "Invalid ticket selling window period.");
        startTime = _startTime;
        endTime = _endTime;
    }

    function setEventDetails(string memory _eventName, uint _maxTickets) public {
        require(bytes(_eventName).length > 0, "Event name cannot be empty");
        require(_maxTickets > 0, "There should be at least one ticket");
        eventName = _eventName;
        maxTickets = _maxTickets;
    }

    function purchaseTicket(string memory attendeeName) public {
        // TODO: Modify function to respect the ticket sales period
        require(totalTicketsSold < maxTickets, "All tickets have been sold");
        require(block.timestamp >= startTime &&  block.timestamp <= endTime, "Ticket selling window has been closed.");
        uint ticketId = totalTicketsSold + 1;
        // TODO: Include Ticket purchase timestamp
        ticketsSold[ticketId] = Ticket(attendeeName, ticketId, false, block.timestamp);
        totalTicketsSold += 1;
        // TODO: Emit event with timestamp
        emit TicketPurchased(ticketId, attendeeName, block.timestamp);
    }

    function useTicket(uint ticketId) public {
        require(ticketId > 0 && ticketId <= totalTicketsSold, "Invalid ticket ID");
        Ticket storage ticket = ticketsSold[ticketId];
        require(!ticket.isUsed, "Ticket already used");
        ticket.isUsed = true;
    }
}
