extends KinematicBody2D

var speed = Vector2(128,128) # 64 пикселя в секунду
var speed_poumolchaniu = speed
var rng = RandomNumberGenerator.new()
var xx = 0
var yy = 0
var dir = Vector2(1, 0)
var dir_viewport
var uscorenie = true
var random_speed
var life_mouse = 3
var rotation_speed = 10

export (Vector2) var coord = Vector2(0, 0) # изменяемые коор. к которым стремится мышь

func _ready():
	var screenSize = get_viewport().get_visible_rect().size
	#срабатывает один раз,чтобы мы получили первичные случайные координаты
	dir = Vector2(rand_range(0, screenSize.x), rand_range(0, screenSize.y))
	

func _physics_process(delta):
	
	var v = (dir - global_position).normalized()#получаем вектор
	var angle = v.angle()#получаем угол
	var r = global_rotation
	var angle_delta = rotation_speed * delta
	angle = lerp_angle(r,angle,1.0)
	angle = clamp(angle, r - angle_delta,r + angle_delta)
	global_rotation = angle
	
	var screenSize = get_viewport().get_visible_rect().size
	randomize()
	
	if life_mouse == 0:
		queue_free()
	
	if global_position.x != dir.x && global_position.y != dir.y:
		#dir = Vector2(rand_range(0, 1024), rand_range(0, 600))#получаем
	#случайные координаты для перемещения абстрактной мышки
		dir_viewport = dir
		
		var direction_vector = dir - global_position#вычисляем вектор
		if direction_vector.length() < 3:#чтобы мышка не дрожала
			return
		move_and_slide(direction_vector.normalized() * speed)#тут непосредственно уже начинаем движение
	if global_position.x +5 >= int(dir.x) && global_position.y + 5 >= int(dir.y):
		dir = Vector2(rand_range(0, screenSize.x), rand_range(0, screenSize.y))
		if uscorenie:
			random_speed = int(rand_range(0, 5))
			if random_speed == 5:
				speed = Vector2(256, 256)
				$TimerSpeed.wait_time = 2
				$TimerSpeed.start()
			elif random_speed == 1:
				speed = Vector2(512, 512)
				$TimerSpeed.wait_time = 2
				$TimerSpeed.start()

func random_coords():#генерация рандомных новых координат
	rng.randomize()
	xx = rng.randi_range(0, 1024)
	yy = rng.randi_range(0, 600)
	dir = Vector2 (xx, yy)
	dir = move_and_slide(coord)
	print (coord)


func _on_TimerSpeed_timeout():
	speed = speed_poumolchaniu#чтобы вернуть первоначальное значение скорости
	uscorenie = true

func _on_TextureButton_pressed():
	life_mouse -= 1
	speed = Vector2(1024, 1024)
	$TimerSpeed.wait_time = 2
	$TimerSpeed.start()
	uscorenie = false
