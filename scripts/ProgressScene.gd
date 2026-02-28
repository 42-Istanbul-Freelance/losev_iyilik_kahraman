extends Control

@onready var level_label: Label = $LevelLabel
@onready var xp_label: Label = $XPLabel
@onready var xp_bar: ProgressBar = $XPBar
@onready var streak_label: Label = $StreakLabel
@onready var badges_container: FlowContainer = $BadgeFlow
@onready var modules_list: VBoxContainer = $ModulesList

func _ready():
	_refresh_ui()

func _refresh_ui():
	if level_label:
		level_label.text = "🏆 Seviye %d" % GameData.get_level()
	if xp_label:
		xp_label.text = "⭐ Toplam XP: %d" % GameData.xp
	if xp_bar:
		xp_bar.max_value = 100
		xp_bar.value = GameData.xp % 100
	if streak_label:
		streak_label.text = "🔥 Günlük Seri: %d gün" % GameData.streak

	if badges_container:
		for child in badges_container.get_children():
			child.queue_free()
		if GameData.badges.is_empty():
			var lbl = Label.new()
			lbl.text = "Henüz rozet yok. Modülleri tamamla!"
			badges_container.add_child(lbl)
		else:
			for badge in GameData.badges:
				var lbl = Label.new()
				lbl.text = "🏅 " + badge.replace("_badge", "").capitalize()
				lbl.add_theme_font_size_override("font_size", 16)
				badges_container.add_child(lbl)

	if modules_list:
		for child in modules_list.get_children():
			child.queue_free()
		if GameData.completed_modules.is_empty():
			var lbl = Label.new()
			lbl.text = "Henüz modül tamamlanmadı."
			modules_list.add_child(lbl)
		else:
			for mod_id in GameData.completed_modules:
				var lbl = Label.new()
				lbl.text = "✅ " + mod_id.capitalize()
				lbl.add_theme_font_size_override("font_size", 16)
				modules_list.add_child(lbl)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
