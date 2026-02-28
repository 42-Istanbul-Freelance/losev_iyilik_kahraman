extends Control

@onready var xp_label: Label = $XPLabel
@onready var streak_label: Label = $StreakLabel
@onready var level_label: Label = $LevelLabel
@onready var character_sprite: TextureRect = $CharacterSprite
@onready var start_btn: Button = $StartButton
@onready var progress_btn: Button = $ProgressButton

func _ready():
	_apply_styles()
	_update_stats()
	_animate_character()

func _apply_styles():
	UITheme.apply_button_style(start_btn, Color(0.2, 0.6, 0.95))
	UITheme.apply_button_style(progress_btn, Color(0.55, 0.3, 0.85))

func _update_stats():
	if xp_label:
		xp_label.text = "⭐  %d XP" % GameData.xp
	if streak_label:
		streak_label.text = "🔥  %d günlük seri" % GameData.streak
	if level_label:
		level_label.text = "SEVİYE  %d" % GameData.get_level()

func _animate_character():
	if not character_sprite:
		return
	var start_y = character_sprite.position.y
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(character_sprite, "position:y", start_y - 10.0, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(character_sprite, "position:y", start_y, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")

func _on_progress_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ProgressScene.tscn")
