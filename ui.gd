extends PanelContainer

@onready var synthesizer = $Synthesizer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_oscillator_settings_settings_changed(wave_type, transpose, fine_tune, level):
	synthesizer.wave_1 = wave_type
	synthesizer.level_1 = level



func _on_oscillator_settings_2_settings_changed(wave_type, transpose, fine_tune, level):
	synthesizer.wave_2 = wave_type
	synthesizer.level_2 = level
