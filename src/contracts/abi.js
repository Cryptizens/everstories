export const abi = [
	{
		"constant": false,
		"inputs": [
			{
				"name": "_lat",
				"type": "int256"
			},
			{
				"name": "_lon",
				"type": "int256"
			},
			{
				"name": "_timing",
				"type": "bytes32"
			},
			{
				"name": "_story",
				"type": "bytes32"
			}
		],
		"name": "recordMemory",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "moderateMemory",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getMemoriesCount",
		"outputs": [
			{
				"name": "count",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "memories",
		"outputs": [
			{
				"name": "lat",
				"type": "int256"
			},
			{
				"name": "lon",
				"type": "int256"
			},
			{
				"name": "timing",
				"type": "bytes32"
			},
			{
				"name": "story",
				"type": "bytes32"
			},
			{
				"name": "owner",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "curator",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "memoryId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "lat",
				"type": "int256"
			},
			{
				"indexed": false,
				"name": "lon",
				"type": "int256"
			},
			{
				"indexed": false,
				"name": "timing",
				"type": "bytes32"
			},
			{
				"indexed": false,
				"name": "story",
				"type": "bytes32"
			},
			{
				"indexed": false,
				"name": "owner",
				"type": "address"
			}
		],
		"name": "NewMemory",
		"type": "event"
	}
]
