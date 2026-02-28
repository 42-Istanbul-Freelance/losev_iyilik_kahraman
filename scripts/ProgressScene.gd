extends Control

@onready var level_label: Label = $LevelLabel
@onready var xp_label: Label = $XPLabel
@onready var xp_bar: ProgressBar = $XPBar
@onready var streak_label: Label = $StreakLabel
@onready var badges_container: FlowContainer = $BadgeFlow
@onready var modules_list: VBoxContainer = $ModulesList
@onready var back_btn: Button = $BackButton

func _ready():
	_apply_styles()
	_refresh_ui()

func _apply_styles():
	if back_btn:
		UITheme.apply_button_style(back_btn, Color(0.3, 0.3, 0.5))

func _refresh_ui():
	if level_label:
		level_label.text = "🏆  Seviye %d" % GameData.get_level()
	if xp_label:
		xp_label.text = "⭐  Toplam XP: %d  ·  Sonraki: %d XP" % [GameData.xp, (GameData.get_level() * 100) - GameData.xp]
	if xp_bar:
		xp_bar.max_value = 100
		xp_bar.value = GameData.xp % 100
	if streak_label:
		streak_label.text = "🔥  %d günlük seri" % GameData.streak

	if badges_container:
		for child in badges_container.get_children():
			child.queue_free()
		if GameData.badges.is_empty():
			var lbl = Label.new()
			lbl.text = "Henüz rozet yok — modülleri tamamla!"
			lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.9))
			badges_container.add_child(lbl)
		else:
			for badge in GameData.badges:
				var lbl = Label.new()
				lbl.text = "🏅  " + badge.replace("_badge", "").capitalize()
				lbl.add_theme_font_size_override("font_size", 16)
				lbl.add_theme_color_override("font_color", Color(1, 0.85, 0.3))
				badges_container.add_child(lbl)

	if modules_list:
		for child in modules_list.get_children():
			child.queue_free()
		if GameData.completed_modules.is_empty():
			var lbl = Label.new()
			lbl.text = "Henüz modül tamamlanmadı."
			lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.9))
			modules_list.add_child(lbl)
		else:
			for mod_id in GameData.completed_modules:
				var lbl = Label.new()
				lbl.text = "✅  " + mod_id.capitalize()
				lbl.add_theme_font_size_override("font_size", 16)
				lbl.add_theme_color_override("font_color", Color(0.4, 1, 0.6))
				modules_list.add_child(lbl)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
