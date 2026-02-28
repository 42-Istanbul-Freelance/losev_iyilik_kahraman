extends Node

# === AudioManager AutoLoad ===
# Merkezi ses yönetimi: müzik + SFX

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

const SFX_PATHS = {
	"click":    "res://assets/audio/sfx/btn_click.ogg",
	"correct":  "res://assets/audio/sfx/correct.ogg",
	"wrong":    "res://assets/audio/sfx/wrong.ogg",
	"complete": "res://assets/audio/sfx/complete.ogg",
}

var music_volume: float = -10.0  # dB
var sfx_volume: float = -4.0     # dB
var music_enabled: bool = true
var sfx_enabled: bool = true

func _ready():
	# Müzik oynatıcı
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Master"
	music_player.volume_db = music_volume
	add_child(music_player)

	# SFX oynatıcı
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "Master"
	sfx_player.volume_db = sfx_volume
	add_child(sfx_player)

func play_music(path: String):
	if not music_enabled:
		return
	# Aynı müzik çalıyorsa tekrar başlatma
	if music_player.playing and music_player.stream:
		if music_player.stream.resource_path == path:
			return
	var stream = load(path)
	if not stream:
		push_warning("AudioManager: müzik yüklenemedi: " + path)
		return
	# Godot 4'te OggVorbis stream loop ayarı
	if stream.has_method("set_loop"):
		stream.set_loop(true)
	elif "loop" in stream:
		stream.loop = true
	music_player.stream = stream
	music_player.play()



func stop_music():
	if music_player:
		music_player.stop()

func play_sfx(sfx_name: String):
	if not sfx_enabled:
		return
	var path = SFX_PATHS.get(sfx_name, "")
	if path == "" or not ResourceLoader.exists(path):
		return
	var stream = load(path)
	if stream:
		sfx_player.stream = stream
		sfx_player.play()

func set_music_volume(db: float):
	music_volume = db
	if music_player:
		music_player.volume_db = db

func set_sfx_volume(db: float):
	sfx_volume = db
	if sfx_player:
		sfx_player.volume_db = db

func toggle_music(enabled: bool):
	music_enabled = enabled
	if not enabled:
		stop_music()

func toggle_sfx(enabled: bool):
	sfx_enabled = enabled
