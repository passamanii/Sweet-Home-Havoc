extends Node

@export var player: BasePlayer 
@export var anim_robot: AnimationPlayer
@export var dungeon_01_animation: AnimationPlayer
@export var spawner_timer: Timer

func _ready() -> void:
	if !Cutscenes_Controller.showed_enter_dungeon_01_cutscene:
		player.pause()
		first_time_in_dungeon_01_cutscene()
		spawner_timer.stop()

func move_backwards() -> void:
	player.animation_player.play("Walking_Back")
	
func move_right() -> void:
	player.animation_player.play("Walking_Right")

func hit_player() -> void:
	player.animation_player.play("Hurt_Front")
	dungeon_01_animation.play("Knockback_Player")

func first_time_in_dungeon_01_cutscene() -> void:

	player.set_physics_process(false)

	print("QUE?! Onde eu tô?")
	await get_tree().create_timer(0.1).timeout

	print("Isso não é a biblioteca...")
	await get_tree().create_timer(0.1).timeout

	player.animation_player.play("Idle_Right")
	await get_tree().create_timer(1.5).timeout

	player.animation_player.play("Idle_Left")
	await get_tree().create_timer(1.5).timeout

	player.animation_player.play("Idle_Front")
	await get_tree().create_timer(2.5).timeout

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

	dungeon_01_animation.play("Enemy_Approach")
	anim_robot.play("Chasing")

	print("Livro: Primeiro teste.")
	await dungeon_01_animation.animation_finished
	anim_robot.play("Attacking")

	print("Aluno: EI EI EI CALMA AÍ!")
	await get_tree().create_timer(1).timeout

	print("O que foi isso?!")
	await get_tree().create_timer(0.1).timeout

	player.animation_player.play("Idle_Back")
	await get_tree().create_timer(1.5).timeout

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
	anim_robot.play("Hurt")
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
	spawner_timer.start()
	Cutscenes_Controller.showed_enter_dungeon_01_cutscene = true
