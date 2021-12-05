extends Node2D

var speed = Vector2(512,512) # 64 пикселя в секунду
var rng = RandomNumberGenerator.new()
var xx = 0
var yy = 0
var dir = Vector2(1, 0)
var dir_viewport


export (Vector2) var coord = Vector2(0, 0) # изменяемые коор. к которым стремится мышь

func _ready():
	var screenSize = get_viewport().get_visible_rect().size
	#срабатывает один раз,чтобы мы получили первичные случайные координаты
	dir = Vector2(rand_range(0, screenSize.x), rand_range(0, screenSize.y))
	

func _physics_process(delta):
	var screenSize = get_viewport().get_visible_rect().size
	randomize()
	print(dir)
	
	if global_position.x != dir.x && global_position.y != dir.y:
		#dir = Vector2(rand_range(0, 1024), rand_range(0, 600))#получаем
	#случайные координаты для перемещения абстрактной мышки
		dir_viewport = dir
		print(screenSize)
		
		var direction_vector = dir - $MouseB.global_position#вычисляем вектор
		if direction_vector.length() < 3:#чтобы мышка не дрожала
			return
		move_and_slide(direction_vector.normalized() * speed)#тут непосредственно уже начинаем движение
	if global_position.x +5 >= int(dir.x) && global_position.y + 5 >= int(dir.y):
		dir = Vector2(rand_range(0, screenSize.x+100), rand_range(0, screenSize.y+100))



func random_coords():#генерация рандомных новых координат
	rng.randomize()
	xx = rng.randi_range(0, 1024)
	yy = rng.randi_range(0, 600)
	dir = Vector2 (xx, yy)
	dir = move_and_slide(coord)
	print (coord)

func random_coords_new():
	pass
