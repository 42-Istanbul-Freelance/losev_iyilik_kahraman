extends Node

# === Kalıcı oyun verisi ===
const SAVE_PATH = "user://save.json"

var xp: int = 0
var streak: int = 0
var last_play_date: String = ""
var completed_modules: Array = []
var badges: Array = []

func _ready():
	load_data()
	check_streak()

func add_xp(amount: int):
	xp += amount
	save_data()

func complete_module(module_id: String):
	if module_id not in completed_modules:
		completed_modules.append(module_id)
		add_xp(50)
		earn_badge(module_id + "_badge")
	save_data()

func earn_badge(badge_id: String):
	if badge_id not in badges:
		badges.append(badge_id)

func check_streak():
	var today = Time.get_date_string_from_system()
	if last_play_date == "":
		streak = 1
	else:
		var last = last_play_date.split("-")
		var today_parts = today.split("-")
		# Sadece gün farkını kontrol et (basit yaklaşım)
		if last_play_date != today:
			streak += 1
	last_play_date = today
	save_data()

func get_level() -> int:
	return int(xp / 100) + 1

func save_data():
	var data = {
		"xp": xp,
		"streak": streak,
		"last_play_date": last_play_date,
		"completed_modules": completed_modules,
		"badges": badges
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(text)
		if parsed:
			xp = parsed.get("xp", 0)
			streak = parsed.get("streak", 0)
			last_play_date = parsed.get("last_play_date", "")
			completed_modules = parsed.get("completed_modules", [])
			badges = parsed.get("badges", [])
