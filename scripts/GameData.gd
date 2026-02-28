extends Node

# === Kalıcı oyun verisi ===
const SAVE_PATH = "user://save.json"

var xp: int = 0
var streak: int = 0
var last_play_date: String = ""
var completed_modules: Array = []
var badges: Array = []
var completed_daily_tasks: Dictionary = {}  # {"module_id": "YYYY-MM-DD"}

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

func complete_daily_task(module_id: String):
	var today = Time.get_date_string_from_system()
	completed_daily_tasks[module_id] = today
	add_xp(25)
	save_data()

func is_daily_task_completed_today(module_id: String) -> bool:
	var today = Time.get_date_string_from_system()
	return completed_daily_tasks.get(module_id, "") == today

func check_streak():
	var today = Time.get_date_string_from_system()
	if last_play_date == "":
		streak = 1
	elif last_play_date != today:
		# Tarihler arası gün farkını hesapla
		var last_unix = _date_string_to_unix(last_play_date)
		var today_unix = _date_string_to_unix(today)
		var day_diff = int((today_unix - last_unix) / 86400.0)  # 86400 saniye = 1 gün

		if day_diff == 1:
			# Ardışık gün - seri devam ediyor
			streak += 1
		elif day_diff > 1:
			# Seri koptu, yeniden başla
			streak = 1
		# day_diff == 0 ise aynı gün, streak değişmez

	last_play_date = today
	save_data()

func _date_string_to_unix(date_str: String) -> int:
	# "YYYY-MM-DD" formatından Unix timestamp'e çevir
	var parts = date_str.split("-")
	if parts.size() != 3:
		return 0
	var dict = {
		"year": int(parts[0]),
		"month": int(parts[1]),
		"day": int(parts[2])
	}
	return Time.get_unix_time_from_datetime_dict(dict)

func get_level() -> int:
	return int(xp / 100) + 1

func save_data():
	var data = {
		"xp": xp,
		"streak": streak,
		"last_play_date": last_play_date,
		"completed_modules": completed_modules,
		"badges": badges,
		"completed_daily_tasks": completed_daily_tasks
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
			completed_daily_tasks = parsed.get("completed_daily_tasks", {})
