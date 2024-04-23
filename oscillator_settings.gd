extends PanelContainer

@onready var wave_option_button = %WaveOptionButton
@onready var trans_spin_box = %TransSpinBox
@onready var fine_h_slider = %FineHSlider
@onready var level_v_slider = %LevelVSlider

signal settings_changed(wave_type:Globals.OscType,transpose,fine_tune,level)

func _on_any_setting_changed(_value):
	settings_changed.emit(wave_option_button.selected,trans_spin_box.value,fine_h_slider.value, level_v_slider.value)
