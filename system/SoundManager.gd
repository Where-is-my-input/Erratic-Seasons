extends Node

# we address the strings to the constants so it's easier to get them from another methods, without the need of type the exactly string
const SOUNDTRACK_SNOW_SLEDS = "snowSleds"
const SOUNDTRACK_THEME_PARK = "themePark"
const SOUNDTRACK_MICHAEL_HOUSE = "michaelHouse"
const SOUNDTRACK_SNOW_BALL = "snowBall"
const SOUNDTRACK_CHARACTER_BACKGROUND = "characterBackground"
const SFX_GET_HIT = "getHit"
const SFX_ROLLDICE = "rollDice"
const SOUNDTRACK_PLEASE_ANSWEAR_ME = "pleaseAnswearMe"
const SOUNDTRACK_LAST_ENCOUTER = "lastEncounter"

#It's a dictionary, meaning that the left side are the keys and the right side are the values
var SOUNDS = {
	SOUNDTRACK_SNOW_SLEDS: preload("res://assets/sound/music/Circlerun - Seasons Forever - Erikas Snow Sleds.mp3"),
	SOUNDTRACK_THEME_PARK: preload("res://assets/sound/music/Circlerun - Seasons Forever - Nikkis Theme Park.mp3"),
	SOUNDTRACK_MICHAEL_HOUSE: preload("res://assets/sound/music/Circlerun - Seasons Forever - Michaels House.mp3"),
	SOUNDTRACK_SNOW_BALL: preload("res://assets/sound/music/Circlerun - Seasons Forever - Snow Ball Fight!!!.mp3"),
	SOUNDTRACK_CHARACTER_BACKGROUND: preload("res://assets/sound/music/Circlerun - Seasons Forever - Character Background Screen.mp3"),
	SFX_GET_HIT: preload("res://assets/sound/sfx/hit01.wav"),
	SFX_ROLLDICE: preload("res://assets/sound/sfx/shake-and-roll-dice-soundbible.mp3"),
	SOUNDTRACK_PLEASE_ANSWEAR_ME: preload("res://assets/sound/music/Please, answer me my friend.mp3"),
	SOUNDTRACK_LAST_ENCOUTER: preload("res://assets/sound/music/The Last Encounter (90s RPG Version) Full Loop.wav"),
	#SOUND_MUSIC1: preload("res://assets/sound/Farm Frolics.ogg"),
	#SOUND_MUSIC2: preload("res://assets/sound/Flowing Rocks.ogg"),
	#SOUND_PICKUP: preload("res://assets/sound/pickup5.ogg"),
	#SOUND_BOSS_ARRIVE: preload("res://assets/sound/boss_arrive.wav"),
	#SOUND_WIN: preload("res://assets/sound/you_win.ogg")
}

# player -> where the soundPlayer is, clip_key the song that will actually play
func PlayClip(player, clip_key: String):
	#check if the key exist, if not just return
	if SOUNDS.has(clip_key) == false:
		return
	# if it do exist, then we change it to the correctly SoundPlayer and play it 
	player.stream = SOUNDS[clip_key]
	#player.set_loop_mode(1)
	player.play()
