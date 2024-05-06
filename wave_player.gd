extends AudioStreamPlayer

var sample_rate = stream.mix_rate
var playback 

var functions = [sinewave,square,triangle,sawtooth]

func generate_wave(notes_dict:Dictionary, wave_function_1, level_1, wave_function_2, level_2):
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
			frame += Vector2.ONE * functions[wave_function_1].call(phases[key]) * level_1 / 127 * notes_dict[key] / 127
			frame += Vector2.ONE * functions[wave_function_2].call(phases[key]) * level_2 / 127 * notes_dict[key] / 127
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
