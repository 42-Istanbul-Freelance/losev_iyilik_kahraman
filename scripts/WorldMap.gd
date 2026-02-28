extends Control

const MODULES_PATH = "res://content/modules.json"

@onready var modules_container: GridContainer = $ScrollContainer/ModulesGrid

var modules_data = []

func _ready():
	_load_modules()
	_build_module_buttons()

func _load_modules():
	var file = FileAccess.open(MODULES_PATH, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(text)
		if parsed:
			modules_data = parsed["modules"]

func _build_module_buttons():
	if not modules_container:
		return
	for module in modules_data:
		var btn = _create_module_button(module)
		modules_container.add_child(btn)

func _create_module_button(module: Dictionary) -> Button:
	var btn = Button.new()
	btn.text = "%s\n%s" % [module["icon"], module["title"]]
	btn.custom_minimum_size = Vector2(160, 110)
	btn.add_theme_font_size_override("font_size", 17)

	var col = Color(module.get("color", "#4488ff"))

	if module["id"] in GameData.completed_modules:
		UITheme.apply_module_button_style(btn, Color(0.3, 0.9, 0.4))
		btn.text = "✅ " + btn.text
	else:
		UITheme.apply_module_button_style(btn, col)

	btn.pressed.connect(_on_module_pressed.bind(module))
	return btn

func _on_module_pressed(module: Dictionary):
	AudioManager.play_sfx("click")
	LessonBridge.current_module = module
	get_tree().change_scene_to_file("res://scenes/LessonScene.tscn")

func _on_back_button_pressed():
	AudioManager.play_sfx("click")
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
