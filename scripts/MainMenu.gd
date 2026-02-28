extends Control

@onready var xp_label: Label = $XPLabel
@onready var streak_label: Label = $StreakLabel
@onready var level_label: Label = $LevelLabel
@onready var character_sprite: TextureRect = $CharacterSprite

func _ready():
	_update_stats()
	_animate_character()

func _update_stats():
	if xp_label:
		xp_label.text = "⭐ XP: %d" % GameData.xp
	if streak_label:
		streak_label.text = "🔥 Seri: %d gün" % GameData.streak
	if level_label:
		level_label.text = "SEVİYE %d" % GameData.get_level()

func _animate_character():
	if not character_sprite:
		return
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(character_sprite, "position:y", character_sprite.position.y - 8.0, 0.9)
	tween.tween_property(character_sprite, "position:y", character_sprite.position.y, 0.9)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")

func _on_progress_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ProgressScene.tscn")
