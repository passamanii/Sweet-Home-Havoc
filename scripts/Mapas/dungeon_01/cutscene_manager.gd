extends Node
class_name Dungeon01CutsceneManager

@export var player: BasePlayer 
@export var anim_temp_robot: AnimationPlayer
@export var dungeon_01_animation: AnimationPlayer
@export var spawn_controller: Node

signal cutscene_finished

func _ready() -> void:
	if !Cutscenes_Controller.showed_enter_dungeon_01_cutscene:
		first_time_in_dungeon_01_cutscene()
	else:
		$"../TempRobot".queue_free()

func move_backwards() -> void:
	player.animation_player.play("Walking_Back")
	
func move_right() -> void:
	player.animation_player.play("Walking_Right")

func hit_player() -> void:
	player.animation_player.play("Hurt_Front")
	dungeon_01_animation.play("Knockback_Player")
	await player.animation_player.animation_finished

func first_time_in_dungeon_01_cutscene() -> void:
	Game_Controller.is_cutscene = true
	player.pause()
	spawn_controller.pause()
	

	print("QUE?! Onde eu tô?")
	await get_tree().create_timer(0.1).timeout

	print("Isso não é a biblioteca...")
	await get_tree().create_timer(0.1).timeout

	player.animation_player.play("Idle_Right")
	await get_tree().create_timer(1).timeout

	player.animation_player.play("Idle_Left")
	await get_tree().create_timer(1).timeout

	player.animation_player.play("Idle_Front")
	await get_tree().create_timer(0.1).timeout

	print("Será que eu tô sonhando?")
	await get_tree().create_timer(0.1).timeout

	print("...")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Você buscou conhecimento.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Conhecimento exige prática.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: O quê?! Quem falou isso?")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Primeiro teste.")
	dungeon_01_animation.play("Enemy_Approach")
	anim_temp_robot.play("Chasing")
	await dungeon_01_animation.animation_finished
	
	anim_temp_robot.play("Attacking")
	await dungeon_01_animation.animation_finished
	print("Aluno: EI EI EI CALMA AÍ!")
	await get_tree().create_timer(0.1).timeout

	print("O que foi isso?!")
	await get_tree().create_timer(0.1).timeout

	player.animation_player.play("Idle_Back")
	await get_tree().create_timer(0.1).timeout

	print("Oloko!!! Que trem é esse?!")
	await get_tree().create_timer(0.1).timeout

	print("Parece um ovo... mas ele tá me encarando.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Derrote-o.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eu não sei lutar!")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Você sabe.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Apenas lembre do que leu.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: ...")
	await get_tree().create_timer(0.1).timeout

	print("Eu sinto que devo descer o cacete nele!")
	await get_tree().create_timer(0.1).timeout

	dungeon_01_animation.play("Player_Approach")
	await dungeon_01_animation.animation_finished

	await get_tree().create_timer(0.1).timeout

	player.animation_player.play("Pen_Attack_Back")
	anim_temp_robot.play("Hurt")
	dungeon_01_animation.play("Hitting_Enemy")

	await dungeon_01_animation.animation_finished

	await get_tree().create_timer(0.1).timeout

	$"../TempRobot".queue_free()

	player.animation_player.play("Idle_Front")
	await get_tree().create_timer(0.1).timeout

	print("...")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Isso foi real demais pra ser um sonho.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Este é apenas o começo.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Cada capítulo... um desafio.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Então estudar agora é isso?")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Você queria aprender rápido.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Agora aprenda.")
	await get_tree().create_timer(0.1).timeout

	player.play()
	spawn_controller.start()
	Cutscenes_Controller.showed_enter_dungeon_01_cutscene = true
	Game_Controller.is_cutscene = false

func first_time_finishing_wave_1_cutscene() -> void:
	Game_Controller.is_cutscene = true
	spawn_controller.pause()
	player.pause()
	player.animation_player.play("Idle_Front")

	print("Livro: PAREM.")

	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.set_physics_process(false)
		enemy.anim_player.play("Idle")

	await get_tree().create_timer(0.1).timeout

	print("*As criaturas congelam no mesmo instante.*")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: O que tá acontecendo agora?")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Nada mal.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Para alguém que nunca enfrentou o próprio medo.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Então isso é... parte do estudo?")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Cada erro eliminado é um conceito dominado.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Mas ainda é cedo para comemorar.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: SAIAM.")
	await get_tree().create_timer(1).timeout

	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.set_physics_process(true)

	await get_tree().create_timer(0.5).timeout

	print("*As criaturas recuam como se obedecessem a uma força invisível.*")
	await get_tree().create_timer(0.1).timeout

	await get_tree().create_timer(0.1).timeout

	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.queue_free()

	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eles... simplesmente foram embora.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Não confunda misericórdia com fraqueza.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Isso foi apenas a primeira onda.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Quanto mais você aprende...")
	await get_tree().create_timer(0.1).timeout

	print("Livro: ...mais o conhecimento cobra.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Então isso vai piorar, né?")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Muito.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Quando estiver à beira do colapso...")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Torça para que a wave termine.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Ao final de cada uma...")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Eu darei um fim neles.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: E você poderá respirar.")
	await get_tree().create_timer(0.1).timeout

	print("Livro: Por pouco tempo.")
	await get_tree().create_timer(0.1).timeout

	Game_Controller.is_cutscene = false
	Cutscenes_Controller.showed_first_wave_finished_cutscene = true
	player.play()
	
	cutscene_finished.emit()
