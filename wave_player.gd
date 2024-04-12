extends AudioStreamPlayer

var sample_rate = stream.mix_rate
var pitch = 440.0
var playback 
func _ready():
	play()
	
	generate_wave(pitch, sawtooth)
	
	await get_tree().create_timer(1).timeout
	
	generate_wave(pitch, sinewave)

func generate_wave(pitch, wave_function):
	playback = get_stream_playback()
	var phase = 0.0
	var increment = pitch / sample_rate
	var  frames_available = playback.get_frames_available()
	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * wave_function.call(phase))
		phase = fmod(phase + increment, 1.0)

func sawtooth(phase):
	return 2 * (phase - floor(.5 + phase))

func sinewave(phase):
	return sin(phase * TAU)
