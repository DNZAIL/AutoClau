class_name XPButton
extends Button

@export var player_stats: PlayerStats

@onready var vbox_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	player_stats.changed.connect(_on_player_stats_changed)
	_on_player_stats_changed()

func _on_player_stats_changed() -> void:
	var has_enough_gold := player_stats.gold >= 4
	var max_level := player_stats.level == player_stats.LEVEL_MAX
	disabled = not has_enough_gold or max_level
	
	if has_enough_gold and not max_level:
		vbox_container.modulate.a = 1.0
	else:
		vbox_container.modulate.a = 0.5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Buy XP") and not disabled:
		_on_pressed()

func _on_pressed() -> void:
	player_stats.gold -= 4
	player_stats.xp += 4
