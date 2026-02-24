class_name BasePerk extends Resource

enum SkillType {
	Passiva,
	Ativa
}

@export var perk_name: String 
@export var perk_id: int
@export var skill_type: SkillType
@export var perk_description: String
@export var perk_cost: Array[int] = [ ]
@export var level: int = 0

func apply_perk() -> void:
	pass
