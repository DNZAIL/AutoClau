class_name PlayerStats
extends Resource

const XP_REQUIREMENTS := {
	1: 0,
	2: 2,
	3: 2,
	4: 6,
	5: 10,
	6: 20,
	7: 36,
	8: 48,
	9: 72,
	10: 84
}
const ROLL_RARITIES := {
	1: [UnitStats.Rarity.COMMON],
	2: [UnitStats.Rarity.COMMON],
	3: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON],
	4: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
	5: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC],
	6: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC],
	7: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC, UnitStats.Rarity.LEGENDARY],
	8: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC, UnitStats.Rarity.LEGENDARY],
	9: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC, UnitStats.Rarity.LEGENDARY],
	10: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.EPIC, UnitStats.Rarity.LEGENDARY],
}
const ROLL_CHANCES := {
	1: [1],
	2: [1],
	3: [7.5, 2.5],
	4: [5.5, 3, 1.5],
	5: [4.5, 3.3, 2, 0.2],
	6: [3, 4, 2.5, 0.5],
	7: [1.9, 3, 4, 1, 0.1],
	8: [1.7, 2.4, 3.2, 2.4, 0.3],
	9: [1.5, 1.8, 2.5, 3, 1.2],
	10: [0.5, 1, 2, 4, 2.5]
}
const LEVEL_MAX = 10

@export_range(0, 99) var gold: int : set = _set_gold
@export_range(0, 99) var xp: int : set = _set_xp
@export_range(1, 10) var level: int : set = _set_level

func get_random_rarity_for_level() -> UnitStats.Rarity:
	var rng = RandomNumberGenerator.new()
	var array: Array = ROLL_RARITIES[level]
	var weights: PackedFloat32Array = PackedFloat32Array(ROLL_CHANCES[level])
	
	return array[rng.rand_weighted(weights)]

func get_current_xp_requirement() -> int:
	var next_level = clampi(level + 1, 1, LEVEL_MAX)
	return XP_REQUIREMENTS[next_level]

func _set_gold(value: int) -> void:
	gold = value
	emit_changed()

func _set_xp(value: int) -> void:
	xp = value
	emit_changed()
	
	if level == LEVEL_MAX:
		return
	
	var xp_requirement: int = get_current_xp_requirement()
	
	while level < LEVEL_MAX and xp >= xp_requirement:
		level += 1
		xp -= xp_requirement
		xp_requirement = get_current_xp_requirement()
		emit_changed()

func _set_level(value: int) -> void:
	level = value
	emit_changed()
