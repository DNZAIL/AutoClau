class_name UnitStats
extends Resource

enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

const RARITY_COLORS := {
	Rarity.COMMON: Color("9b9b9b"),
	Rarity.UNCOMMON: Color("124a2e"),
	Rarity.RARE: Color("1c527c"),
	Rarity.EPIC: Color("9334e0"),
	Rarity.LEGENDARY: Color("ea940b")
}

@export var name: String

@export_category("Data")
@export var rarity: Rarity
@export var gold_cost := 1

@export_category("Visuals")
@export var skin_coordinates: Vector2i

func _to_string() -> String:
	return name
