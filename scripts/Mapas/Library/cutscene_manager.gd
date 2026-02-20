extends Node

@export var player: BasePlayer 
@export var old_locker_1: Area2D
@export var library_animation: AnimationPlayer
@export var locker_code_canvas: CanvasLayer

func _ready() -> void:
	if (!Cutscenes_Controller.showed_enter_library_cutscene):
		first_time_in_library_cutscene()
	
	if (Cutscenes_Controller.showed_enter_library_cutscene and !Cutscenes_Controller.showed_first_dungeon_win_cutscene):
		win_coming_back_from_dungeon_cutscene()
	
	if (Cutscenes_Controller.showed_open_locker_1):
		old_locker_1.monitoring = false

func move_backwards() -> void:
	player.animation_player.play("Walking_Back")
	
func move_right() -> void:
	player.animation_player.play("Walking_Right")

func first_time_in_library_cutscene() -> void:
	Game_Controller.is_cutscene = true
	player.pause()
	
	print("Acho que é aqui que vou ter que ficar durante o resto da semana...")
	await get_tree().create_timer(2).timeout

	# Começa animação da biblioteca
	library_animation.play("First_Enter_In_Library")
	await get_tree().create_timer(1).timeout
	print("eu tenho prova essa SEXTA!!!")
	
	# Espera a animação da biblioteca terminar
	await library_animation.animation_finished

	# Para animação do player
	player.animation_player.play("Idle_Right")
	print("Bibliotecário: Bom dia! Como posso te ajudar?")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eu... eu tenho prova na sexta e não estudei nada.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eu preciso aprender tudo até lá. O senhor conhece algum livro que possa me salvar?")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Salvar...")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Existem livros nesta biblioteca que não estão no catálogo.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Livros antigos. Esquecidos.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Alguns dizem que são... amaldiçoados.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Amal... o quê?")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Eles prometem conhecimento rápido.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Rápido demais.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Mas há um problema.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Eles estão trancados nos armários do setor restrito.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Protegidos por uma senha que ninguém jamais conseguiu decifrar.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: E... qual é essa senha?")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: A senha está espalhada pela faculdade.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Cada número escondido onde menos se espera.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Laboratórios. Quadros. Murais antigos.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Apenas quem realmente precisa do conhecimento consegue enxergar.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eu preciso. Muito.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Hmmm...")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Normalmente eu não ajudaria.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Mas...")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Como você é um dev, eu te dou a senha...")
	await get_tree().create_timer(0.1).timeout

	print("*O bibliotecário tira um papel velho e amarelado do bolso do casaco.*")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Anote bem.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: 4... 2... 6... 9.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Mas cuidado.")
	await get_tree().create_timer(0.1).timeout

	print("Bibliotecário: Nem todo conhecimento quer ser encontrado.")
	await get_tree().create_timer(0.1).timeout

	print("*Você sente um arrepio enquanto segura o papel.*")
	await get_tree().create_timer(0.1).timeout

	print("Objetivo atualizado: Encontrar o armário do setor restrito.")
	player.play()
	Cutscenes_Controller.showed_enter_library_cutscene = true
	Game_Controller.is_cutscene = false

func open_locker_cutscene() -> void:
	Game_Controller.is_cutscene = true
	locker_code_canvas.hide()
	player.pause()
	player.animation_player.play("Idle_Back")
	old_locker_1.monitoring = false
	
	print("*O armário do setor restrito range lentamente ao ser aberto.*")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: ...")
	await get_tree().create_timer(0.1).timeout

	print("*Um cheiro de papel antigo e poeira toma o ar.*")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Não tem nada demais aqui...")
	await get_tree().create_timer(0.1).timeout

	print("*As luzes da biblioteca piscam por um breve instante.*")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Tá... isso foi estranho.")
	await get_tree().create_timer(0.1).timeout

	print("*No fundo do armário, um único livro repousa envolto por uma capa escura.*")
	await get_tree().create_timer(0.1).timeout

	print("*O título parece mudar levemente quando você tenta focar nele.*")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: \"Fundamentos Absolutos da Aprovação\"...?")
	await get_tree().create_timer(0.1).timeout

	print("*Ao tocar no livro, um arrepio percorre sua espinha.*")
	await get_tree().create_timer(0.1).timeout

	print("???: Finalmente...")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: ...")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eu ouvi isso mesmo?")
	await get_tree().create_timer(0.1).timeout

	print("*As páginas começam a se folhear sozinhas.*")
	await get_tree().create_timer(0.1).timeout

	print("???: Conhecimento exige um preço.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Preço? Que preço?")
	await get_tree().create_timer(0.1).timeout

	print("*Silêncio absoluto.*")
	await get_tree().create_timer(0.1).timeout

	print("*As letras nas páginas parecem se reorganizar diante dos seus olhos.*")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Isso... isso vai me fazer passar na prova.")
	await get_tree().create_timer(0.1).timeout

	print("Aluno: Eu não tenho escolha.")
	await get_tree().create_timer(0.1).timeout

	print("*O livro finalmente para em um capítulo específico.*")
	await get_tree().create_timer(0.1).timeout

	print("*Você sente como se estivesse sendo observado pelas próprias palavras.*")
	await get_tree().create_timer(0.1).timeout

	print("Objetivo atualizado: Absorver o conhecimento do livro.")
	await get_tree().create_timer(0.1).timeout

	print("*O livro agora está em suas mãos.*")
	
	Cutscenes_Controller.showed_open_locker_1 = true
	Game_Controller.has_first_book = true
	Game_Controller.is_cutscene = false
	player.play()

func win_coming_back_from_dungeon_cutscene() -> void:
	Game_Controller.is_cutscene = true
	player.pause()
	player.animation_player.play("Idle_Front")

	await get_tree().create_timer(2).timeout
	print("*Você pisca os olhos e está de volta à biblioteca.*")
	await get_tree().create_timer(3).timeout

	print("Aluno: ...")
	await get_tree().create_timer(2).timeout

	print("Aluno: Eu voltei?")
	await get_tree().create_timer(2).timeout

	print("*A biblioteca está silenciosa demais.*")
	await get_tree().create_timer(3).timeout

	print("Aluno: Aquilo foi real.")
	await get_tree().create_timer(2).timeout

	print("Aluno: Eu lutei.")
	await get_tree().create_timer(2).timeout

	print("Aluno: Eu venci.")
	await get_tree().create_timer(2).timeout

	print("Livro: Você sobreviveu.")
	await get_tree().create_timer(3).timeout

	print("Aluno: Sobrevivi?!")
	await get_tree().create_timer(2).timeout

	print("Aluno: Eu achei que eu tava estudando!")
	await get_tree().create_timer(3).timeout

	print("Livro: Você absorveu conhecimento bruto.")
	await get_tree().create_timer(3).timeout

	print("Livro: Conceitos. Fórmulas. Definições.")
	await get_tree().create_timer(3).timeout

	print("Livro: Todos despejados em sua mente.")
	await get_tree().create_timer(3).timeout

	print("Aluno: Minha cabeça tá doendo...")
	await get_tree().create_timer(3).timeout

	print("Aluno: Eu sei explicar coisas que eu nem lembro de ter lido.")
	await get_tree().create_timer(3).timeout

	print("Aluno: Mas eu não sei o que realmente importa pra prova.")
	await get_tree().create_timer(4).timeout

	print("Livro: Informação não é entendimento.")
	await get_tree().create_timer(3).timeout

	print("Livro: Você aprendeu demais.")
	await get_tree().create_timer(3).timeout

	print("Livro: Mas não aprendeu o suficiente.")
	await get_tree().create_timer(4).timeout

	print("Aluno: Isso não faz sentido nenhum!")
	await get_tree().create_timer(3).timeout

	print("Livro: Faz.")
	await get_tree().create_timer(2).timeout

	print("Livro: O próximo capítulo filtrará o excesso.")
	await get_tree().create_timer(4).timeout

	print("Livro: Apenas o que for essencial permanecerá.")
	await get_tree().create_timer(4).timeout

	print("Aluno: E se eu não quiser continuar?")
	await get_tree().create_timer(3).timeout

	print("Livro: Você pode fechar o livro.")
	await get_tree().create_timer(3).timeout

	print("Livro: E encarar a prova... vazio.")
	await get_tree().create_timer(4).timeout

	print("...")
	await get_tree().create_timer(3).timeout

	print("Aluno: Eu odeio quando você faz sentido.")
	await get_tree().create_timer(3).timeout

	print("Livro: Prepare-se.")
	await get_tree().create_timer(3).timeout

	print("Livro: O segundo capítulo será menos tolerante.")
	await get_tree().create_timer(4).timeout

	print("Objetivo atualizado: Dominar o próximo capítulo.")
	await get_tree().create_timer(2).timeout

	player.play()
	Game_Controller.is_cutscene = false
	Cutscenes_Controller.showed_first_dungeon_win_cutscene = true
	
