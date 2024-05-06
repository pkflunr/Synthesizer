extends PanelContainer

@onready var on_off_button = %OnOffButton
@onready var hi_lo_pass_button = %HiLoPassButton
@onready var env_button = %EnvButton
@onready var hz_text_edit = %HzTextEdit
@onready var hz_slider = %HzSlider

@onready var filter_bus_id = AudioServer.get_bus_index("Filter Bus")
@export var current_hz = 2000

const LOW_PASS = 0
const HIGH_PASS = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	hz_text_edit.value = current_hz
	hz_slider.value = current_hz


func _on_on_off_button_toggled(toggled_on):
	AudioServer.set_bus_bypass_effects(filter_bus_id,not toggled_on)


func _on_hi_lo_pass_button_toggled(toggled_on):
	AudioServer.set_bus_effect_enabled(filter_bus_id,LOW_PASS,not toggled_on)
	AudioServer.set_bus_effect_enabled(filter_bus_id,HIGH_PASS,toggled_on)

func _on_hz_changed(value):
	current_hz = value
	hz_text_edit.value = current_hz
	hz_slider.value = current_hz
	
	var low_pass = AudioServer.get_bus_effect(filter_bus_id,LOW_PASS)
	var high_pass = AudioServer.get_bus_effect(filter_bus_id,HIGH_PASS)
	
	low_pass.cutoff_hz = value
	high_pass.cutoff_hz = value

