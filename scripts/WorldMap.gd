extends Control

const MODULES_PATH = "res://content/modules.json"

@onready var modules_container: GridContainer = $ScrollContainer/ModulesGrid

var modules_data = []

signal module_selected(module_data)

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
	btn.custom_minimum_size = Vector2(150, 120)
	btn.add_theme_font_size_override("font_size", 18)

	# Modül tamamlandıysa farklı renk
	if module["id"] in GameData.completed_modules:
		btn.modulate = Color(0.6, 1.0, 0.6)  # Yeşilimsi
	else:
		# Hex rengi uygula
		var col = Color(module["color"])
		btn.modulate = col

	btn.pressed.connect(_on_module_pressed.bind(module))
	return btn

func _on_module_pressed(module: Dictionary):
	# Seçilen modülü LessonScene'e aktar
	LessonBridge.current_module = module
	get_tree().change_scene_to_file("res://scenes/LessonScene.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
