extends Node

var playerConfigs = {
	'lives': 3, 
	'speed': 175,
	'alive': true,
}

var ghostConfigs = {
	'speed': 150,
	'speedPerLevel': 5,
}

var pillConfigs = {
	'points': 10,
}

var hudConfigs = {
	'scoreboardNumberOfDigits': 9,
}

var gameStatus = {
	'playing': false,
	'started': false,
	'mode': 'default',
}

var tabuadaConfigs = {
	'lowLimit': 2,
	'highLimit': 9,
	'customLowLimit': 3,
	'customHighLimit': 7,
}
