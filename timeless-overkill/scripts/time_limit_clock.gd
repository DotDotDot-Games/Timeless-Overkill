@tool
extends AnimatedTextureRect

@onready var audio: AudioStreamPlayer = $%ClockAudio

var last_frame: int = 0
var _sounds_cache: Dictionary[int, AudioStreamMP3] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	super._ready()
	
	if Engine.is_editor_hint():
		return
		
	LevelCountDown.start_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	var percent := 1.0 - (LevelCountDown.time_left / LevelCountDown.INITIAL_TIME)
	var frame := int(round(percent * (total_frames()-1)))
	#print("Frame: ", frame, "; Percent: ", percent)
	self.set_frame(frame)
	
	if frame == last_frame:
		return
		
	last_frame = frame
		
	if LevelCountDown.time_left > 15.0:
		return
	
	_clock_sound()

func _clock_sound() -> void:
	
	var idx := (last_frame % 8) + 1
	
	if _sounds_cache.has(idx):
		_play_stream(_sounds_cache[idx])
		return
	
	var dir := "res://assets/audio/clock/0"
	var file := dir + str(idx) + "-clock.mp3"
	var sound: AudioStreamMP3 = load(file)
	
	_sounds_cache[idx] = sound
	_play_stream(sound)

func _play_stream(sound: AudioStreamMP3) -> void:
	audio.stream = sound
	audio.play()
