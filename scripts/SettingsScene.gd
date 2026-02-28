extends Control

@onready var title_label: Label = $TitleLabel
@onready var music_toggle: CheckButton = $MusicToggle
@onready var sfx_toggle: CheckButton = $SFXToggle
@onready var music_slider: HSlider = $MusicSlider
@onready var sfx_slider: HSlider = $SFXSlider
@onready var music_volume_label: Label = $MusicVolumeLabel
@onready var sfx_volume_label: Label = $SFXVolumeLabel
@onready var back_btn: Button = $BackButton

func _ready():
	_apply_styles()
	_load_settings()

func _apply_styles():
	if back_btn:
		UITheme.apply_button_style(back_btn, Color(0.3, 0.3, 0.5))

	# Title styling
	if title_label:
		title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

func _load_settings():
	if music_toggle:
		music_toggle.button_pressed = AudioManager.music_enabled
	if sfx_toggle:
		sfx_toggle.button_pressed = AudioManager.sfx_enabled
	if music_slider:
		music_slider.value = _db_to_percent(AudioManager.music_volume)
		_update_music_label(music_slider.value)
	if sfx_slider:
		sfx_slider.value = _db_to_percent(AudioManager.sfx_volume)
		_update_sfx_label(sfx_slider.value)

func _db_to_percent(db: float) -> float:
	# -30 dB (sessiz) ile 0 dB (max) arası -> 0-100%
	return clamp((db + 30.0) / 30.0 * 100.0, 0, 100)

func _percent_to_db(percent: float) -> float:
	# 0-100% -> -30 dB ile 0 dB arası
	return (percent / 100.0) * 30.0 - 30.0

func _on_music_toggle_toggled(toggled_on: bool):
	AudioManager.toggle_music(toggled_on)
	AudioManager.play_sfx("click")

func _on_sfx_toggle_toggled(toggled_on: bool):
	AudioManager.toggle_sfx(toggled_on)
	if toggled_on:
		AudioManager.play_sfx("click")

func _on_music_slider_value_changed(value: float):
	var db = _percent_to_db(value)
	AudioManager.set_music_volume(db)
	_update_music_label(value)

func _on_sfx_slider_value_changed(value: float):
	var db = _percent_to_db(value)
	AudioManager.set_sfx_volume(db)
	_update_sfx_label(value)
	AudioManager.play_sfx("click")

func _update_music_label(percent: float):
	if music_volume_label:
		music_volume_label.text = "Ses: %d%%" % int(percent)

func _update_sfx_label(percent: float):
	if sfx_volume_label:
		sfx_volume_label.text = "Ses: %d%%" % int(percent)

func _on_back_button_pressed():
	AudioManager.play_sfx("click")
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
