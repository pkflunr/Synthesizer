extends Node

@onready var wave_player = $WavePlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

func _input(input_event):
	if input_event is InputEventMIDI:
		_handle_midi_event(input_event)

func _handle_midi_event(midi_event: InputEventMIDI):
	print(midi_event)
	
	
	if midi_event.message == MIDI_MESSAGE_NOTE_ON:
		wave_player.play()
		wave_player.generate_wave(midi_to_freq(midi_event.pitch), wave_player.square)

# using equal temperament
func midi_to_freq(midi_pitch):
	print(440.0 * (2.0 ** ((midi_pitch - 69.0) / 12.0)))
	return 440.0 * (2.0 ** ((midi_pitch - 69.0) / 12.0))
