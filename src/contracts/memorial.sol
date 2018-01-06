pragma solidity ^0.4.19;

/// @title Memorial.
contract Memorial {
  // Event to notify of a new memory that's been created
  event NewMemory(uint memoryId, string story, int lat, int lon, address owner);

  // The structure holding an individual memory and its location. We use integers
  // for the geographical coordinates. So before sending lat and lon to the
  // contract, we first need to multiply them by 100 then cut off the decimals
  struct Memory {
    string story;  // description of the memory
    int lat; // latitude (with 2 first decimals)
    int lon; // longitude (with 2 first decimals)
    address owner; // creator of the memory
  }

  // The dynamic array holding all the memories
  Memory[] public memories;

  // The mapping holding the number of memories per owner, to avoid
  // spamming from too many memories per address
  mapping (address => uint) ownerMemoryCount;

  // Private function to save the memory to the Blockchain, once its input
  // has been validated. Also updates the utility mappings and emit an Event
  function _saveMemory(string _story, int _lat, int _lon, address _owner) private {
    uint id = memories.push(Memory(_story, _lat, _lon, _owner)) - 1;
    ownerMemoryCount[_owner]++;
    NewMemory(id, _story, _lat, _lon, _owner);
  }

  // Public function to call when requesting the record of a new memory. We
  // prevent spamming from too many memories per address. Also, we ensure
  // the coordinates are within the Earth's boundaries
  function recordMemory(string _story, int _lat, int _lon) public {
    require(ownerMemoryCount[msg.sender] < 10);
    require((_lat <= 9000) && (_lat >= -9000));
    require((_lon <= 18000) && (_lon >= -18000));
    _saveMemory(_story, _lat, _lon, msg.sender);
  }
}
