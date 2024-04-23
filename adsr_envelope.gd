extends PanelContainer

@onready var attack_slider = %AttackSlider
@onready var decay_slider = %DecaySlider
@onready var sustain_slider = %SustainSlider
@onready var release_slider = %ReleaseSlider

signal settings_changed(attack,decay,sustain,release)

func _on_any_setting_changed(_value):
	settings_changed.emit(attack_slider.value, decay_slider.value,sustain_slider.value,release_slider.value)
