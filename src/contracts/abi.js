export const abi = [
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
				"name": "story",
				"type": "string"
			},
			{
				"name": "lat",
				"type": "int256"
			},
			{
				"name": "lon",
				"type": "int256"
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
		"constant": false,
		"inputs": [
			{
				"name": "_story",
				"type": "string"
			},
			{
				"name": "_lat",
				"type": "int256"
			},
			{
				"name": "_lon",
				"type": "int256"
			}
		],
		"name": "recordMemory",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
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
				"name": "story",
				"type": "string"
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
				"name": "owner",
				"type": "address"
			}
		],
		"name": "NewMemory",
		"type": "event"
	}
]
