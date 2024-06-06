// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Importing the Ownable library from OpenZeppelin to use ownership functionality
import "@openzeppelin/contracts/access/Ownable.sol";

// Extending the EventTicketing contract with Ownable to include ownership capabilities
contract EventTicketing is Ownable {
    struct Ticket {
        string attendeeName;
        uint ticketId;
        bool isUsed;
        uint timestamp; // Timestamp to record when the ticket was purchased
    }

    string public eventName;
    uint public totalTicketsSold;
    uint public maxTickets;
    mapping(uint => Ticket) public ticketsSold;
    event TicketPurchased(uint ticketId, string attendeeName, uint timestamp);

    uint public startTime;
    uint public endTime;

    // Modifier to ensure ticket sales occur within the designated period
    modifier salesOpen() {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Ticket sales are not open.");
        _;
    }

    constructor(uint _startTime, uint _endTime, address initialOwner) Ownable(initialOwner) {
        require(_endTime > _startTime, "End time must be after start time.");
        startTime = _startTime;
        endTime = _endTime;
    }

    // Function to set event details that can only be called by the owner of the contract
    function setEventDetails(string memory _eventName, uint _maxTickets) public onlyOwner {
        require(bytes(_eventName).length > 0, "Event name cannot be empty.");
        require(_maxTickets > 0, "There should be at least one ticket.");
        eventName = _eventName;
        maxTickets = _maxTickets;
    }

    // Function to allow attendees to purchase tickets, ensuring sales are within the allowed period
    function purchaseTicket(string memory attendeeName) public salesOpen {
        require(totalTicketsSold < maxTickets, "All tickets have been sold.");
        uint ticketId = totalTicketsSold + 1;
        ticketsSold[ticketId] = Ticket(attendeeName, ticketId, false, block.timestamp);
        totalTicketsSold += 1;
        emit TicketPurchased(ticketId, attendeeName, block.timestamp);
    }

    // Function to mark a ticket as used, validating ticket ID and usage status
    function useTicket(uint ticketId) public {
        require(ticketId > 0 && ticketId <= totalTicketsSold, "Invalid ticket ID.");
        Ticket storage ticket = ticketsSold[ticketId];
        require(!ticket.isUsed, "Ticket already used.");
        ticket.isUsed = true;
    }
}
