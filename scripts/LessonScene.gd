extends Control

@onready var title_label: Label = $TitleLabel
@onready var lesson_counter: Label = $LessonCounter
@onready var xp_bar: ProgressBar = $XPBar
@onready var character_sprite: TextureRect = $CharacterSprite
@onready var lesson_text: RichTextLabel = $LessonPanel/LessonText
@onready var lesson_panel: PanelContainer = $LessonPanel
@onready var question_panel: PanelContainer = $QuestionPanel
@onready var question_label: Label = $QuestionLabel
@onready var options_container: VBoxContainer = $OptionsContainer
@onready var feedback_label: Label = $FeedbackLabel
@onready var next_btn: Button = $NextButton
@onready var daily_task_panel: PanelContainer = $DailyTaskPanel
@onready var daily_task_label: Label = $DailyTaskLabel
@onready var task_done_btn: Button = $TaskDoneButton

var current_module: Dictionary = {}
var lessons: Array = []
var current_lesson_index: int = 0

const CHAR_BASE_PATH = "res://assets/kenney_toon/"
const CHAR_PATHS = {
	"malePerson": "Male person/PNG/Poses HD/character_malePerson_%s.png",
	"femalePerson": "Female person/PNG/Poses HD/character_femalePerson_%s.png"
}

func _ready():
	current_module = LessonBridge.current_module
	if current_module.is_empty():
		get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")
		return
	lessons = current_module.get("lessons", [])
	if title_label:
		title_label.text = "%s %s" % [current_module.get("icon",""), current_module.get("title","")]
	_show_lesson(0)

func _show_lesson(index: int):
	if index >= lessons.size():
		_show_daily_task()
		return

	var lesson = lessons[index]
	if lesson_counter:
		lesson_counter.text = "Ders %d / %d" % [index + 1, lessons.size()]
	if lesson_text:
		lesson_text.text = lesson.get("text", "")
	if lesson_panel:
		lesson_panel.show()
	if question_panel:
		question_panel.hide()
	if question_label:
		question_label.hide()
	if options_container:
		options_container.hide()
	if feedback_label:
		feedback_label.hide()
	if daily_task_panel:
		daily_task_panel.hide()
	if daily_task_label:
		daily_task_label.hide()
	if task_done_btn:
		task_done_btn.hide()
	if next_btn:
		next_btn.text = "Soruya Git →"
		next_btn.show()
	if xp_bar:
		xp_bar.value = GameData.xp % 100

	_load_character(lesson.get("character", "malePerson"), lesson.get("pose", "idle"))

func _load_character(char_type: String, pose: String):
	if not character_sprite:
		return
	if not CHAR_PATHS.has(char_type):
		return
	var path = CHAR_BASE_PATH + CHAR_PATHS[char_type] % pose
	if ResourceLoader.exists(path):
		character_sprite.texture = load(path)
	else:
		var fallback = CHAR_BASE_PATH + CHAR_PATHS[char_type] % "idle"
		if ResourceLoader.exists(fallback):
			character_sprite.texture = load(fallback)

func _show_question():
	var lesson = lessons[current_lesson_index]
	var q = lesson.get("question", {})
	if q.is_empty():
		current_lesson_index += 1
		_show_lesson(current_lesson_index)
		return

	if question_label:
		question_label.text = q.get("text", "")
		question_label.show()
	if lesson_panel:
		lesson_panel.hide()
	if question_panel:
		question_panel.show()
	if feedback_label:
		feedback_label.hide()
	if next_btn:
		next_btn.hide()

	if options_container:
		for child in options_container.get_children():
			child.queue_free()
		var options = q.get("options", []).duplicate()
		options.shuffle()
		for opt in options:
			var btn = Button.new()
			btn.text = opt.get("text", "")
			btn.add_theme_font_size_override("font_size", 15)
			btn.pressed.connect(_on_option_pressed.bind(opt.get("correct", false), btn))
			options_container.add_child(btn)
		options_container.show()

func _on_option_pressed(is_correct: bool, btn: Button):
	if options_container:
		for child in options_container.get_children():
			child.disabled = true
	if feedback_label:
		feedback_label.show()
		if is_correct:
			btn.modulate = Color(0.4, 1.0, 0.4)
			feedback_label.text = "✅ Harika! Doğru cevap!"
			feedback_label.add_theme_color_override("font_color", Color(0.2, 0.8, 0.2))
			GameData.add_xp(15)
			_bounce_character()
		else:
			btn.modulate = Color(1.0, 0.4, 0.4)
			feedback_label.text = "❌ Yanlış! Tekrar dene."
			feedback_label.add_theme_color_override("font_color", Color(0.9, 0.2, 0.2))
	if next_btn:
		next_btn.text = "Devam →"
		next_btn.show()

func _bounce_character():
	if not character_sprite:
		return
	var tween = create_tween()
	tween.tween_property(character_sprite, "scale", Vector2(1.2, 1.2), 0.15)
	tween.tween_property(character_sprite, "scale", Vector2(1.0, 1.0), 0.15)

func _show_daily_task():
	if lesson_panel:
		lesson_panel.hide()
	if question_panel:
		question_panel.hide()
	if question_label:
		question_label.hide()
	if options_container:
		options_container.hide()
	if feedback_label:
		feedback_label.hide()
	if next_btn:
		next_btn.hide()
	if daily_task_panel:
		daily_task_panel.show()
	if daily_task_label:
		daily_task_label.text = current_module.get("daily_task", "")
		daily_task_label.show()
	if task_done_btn:
		task_done_btn.show()
	GameData.complete_module(current_module.get("id", ""))

func _on_next_button_pressed():
	if question_panel and not question_panel.visible:
		_show_question()
	else:
		current_lesson_index += 1
		_show_lesson(current_lesson_index)

func _on_task_done_pressed():
	GameData.add_xp(25)
	get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")
