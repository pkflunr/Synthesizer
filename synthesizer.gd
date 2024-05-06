extends Node

@onready var wave_player = $WavePlayer

var notes_dict = {}

var wave_1 = 0
var wave_2 = 0
var level_1 = 0
var level_2 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

func _input(input_event):
	if input_event is InputEventMIDI:
		_handle_midi_event(input_event)

func _handle_midi_event(midi_event: InputEventMIDI):
	if midi_event.message == MIDI_MESSAGE_NOTE_ON:
		notes_dict[midi_to_freq(midi_event.pitch)] = midi_event.velocity
		wave_player.play()
		wave_player.generate_wave(notes_dict, wave_1, level_1, wave_2, level_2)
	
	if midi_event.message == MIDI_MESSAGE_NOTE_OFF:
		notes_dict.erase(midi_to_freq(midi_event.pitch))
		if notes_dict.is_empty():
			wave_player.stop()
		else:
			wave_player.play()
			wave_player.generate_wave(notes_dict, wave_1, level_1, wave_2, level_2)

# using equal temperament
func midi_to_freq(midi_pitch):
	return 440.0 * (2.0 ** ((midi_pitch - 69.0) / 12.0))
