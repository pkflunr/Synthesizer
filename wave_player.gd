extends AudioStreamPlayer

var sample_rate = stream.mix_rate
var playback 

func generate_wave(notes_dict:Dictionary, wave_function):
	print(notes_dict)
	playback = get_stream_playback()
	var phases = {}
	var increments = {}
	for key in notes_dict.keys():
		phases[key] = 0.0
		increments[key] = key / sample_rate

	var  frames_available = playback.get_frames_available()
	for i in range(frames_available):
		var frame = Vector2.ZERO
		for key in notes_dict.keys():
			frame += Vector2.ONE * wave_function.call(phases[key]) * notes_dict[key] / 127
		playback.push_frame(frame)
		for key in notes_dict.keys():
			phases[key] += increments[key]

func sawtooth(phase):
	return 2 * (phase - floor(.5 + phase))

func sinewave(phase):
	return sin(phase * TAU)

func square(phase):
	return sign(sin(phase * TAU))

func triangle(phase):
	return 2 * abs(2 * (phase - floor(phase + .5))) - 1
