pragma solidity ^0.4.19;

/// @title Memorial.
contract Memorial {
  // Event to notify of a new memory that's been created
  event NewMemory(uint memoryId, int lat, int lon, bytes32 timing, bytes32 story, address owner);

  // Populated at contract creation
  address public curator = msg.sender;

  // The structure holding an individual memory and its location. We use integers
  // for the geographical coordinates. So before sending lat and lon to the
  // contract, we first need to multiply them by 10000 then cut off the decimals
  struct Memory {
    int lat; // latitude (with 4 first decimals)
    int lon; // longitude (with 4 first decimals)
    bytes32 timing; // timing of the memory
    bytes32 story;  // description of the memory
    address owner;  // creator of the memory
  }

  // The dynamic array holding all the memories
  Memory[] public memories;

  // The mapping holding the number of memories per owner, to avoid
  // spamming from too many memories per address
  mapping (address => uint) ownerMemoryCount;

  // Functions modifier to grant specific privileges to the curator
  modifier onlyByCurator {
      require(msg.sender == curator);
      // Now execute function body
      _;
  }

  // Hopefully not needed, but useful still
  function moderateMemory(uint _id) public onlyByCurator {
    Memory storage m = memories[_id];
    // Will be used as a flag for later retrieval from the DApp, to then
    // choose not to display this memory
    m.story = 'MODERATED';
  }

  // Public constant function to get the count of memories, useful
  // when iterating over the array of memories;
  function getMemoriesCount() public constant returns (uint count) {
    return memories.length;
  }

  // Public function to call when requesting the record of a new memory. We
  // prevent spamming from too many memories per address. Also, we ensure
  // the coordinates are within the Earth's boundaries
  function recordMemory(int _lat, int _lon, bytes32 _timing, bytes32 _story) public {
    require(ownerMemoryCount[msg.sender] < 10);
    require((_lat <= 900000) && (_lat >= -900000));
    require((_lon <= 1800000) && (_lon >= -1800000));
    _saveMemory(_lat, _lon, _timing, _story, msg.sender);
  }

  // Private function to save the memory to the Blockchain, once its input
  // has been validated. Also updates the utility mappings and emits an Event
  function _saveMemory(int _lat, int _lon, bytes32 _timing, bytes32 _story, address _owner) private {
    uint id = memories.push(Memory(_lat, _lon, _timing, _story, msg.sender)) - 1;
    ownerMemoryCount[_owner]++;
    NewMemory(id, _lat, _lon, _timing, _story, _owner);
  }
}
