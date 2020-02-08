extends Node

var playerConfigs = {
	'lives': 3, 
	'speed': 400,
}

var ghostConfigs = {
	'speed': 90,
	'speedPerLevel': 5,
}

var pillConfigs = {
	'points': 10,
}

var hudConfigs = {
	'scoreboardNumberOfDigits': 8,
}

var gameStatus = {
	'playing': false,
	'mode': 'default',
}

var tabuadaConfigs = {
	'lowLimit': 2,
	'highLimit': 9,
	'customLowLimit': 3,
	'customHighLimit': 7,
}
