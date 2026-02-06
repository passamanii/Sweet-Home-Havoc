extends Resource
class_name SkillData

enum skill_type {ACTIVATABLE, PASSIVE}

@export_category("Variables")
@export var id: String
@export var type: skill_type
@export var name: String
@export var text: String
@export var cost: int
@export var requirements: Array[String]
@export var img: Texture2D
