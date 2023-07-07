extends Node3D

var player: Player
var playerCamera: Camera3D
var teleportDelay: float = 2.5
var teleportTimer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player") as Player
	playerCamera = player.get_node("RotationHelper/Camera3D") as Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if is_player_looking():
		stop_teleport_timer()
	else:
		start_teleport_timer(delta)
		
	if (teleportTimer >= teleportDelay):
		teleport_to_player()
		reset_teleport_timer()

func screen_exited():
	print("snap")
	$NeckSnap.play()
	pass # Replace with function body.

func is_player_looking() -> bool:
	if playerCamera:
		var direction_to_player = global_transform.origin - playerCamera.global_transform.origin
		return not playerCamera.is_position_behind(direction_to_player)
	return false

func start_teleport_timer(delta: float):
	teleportTimer += delta

func stop_teleport_timer():
	teleportTimer = 0.0

func reset_teleport_timer():
	teleportTimer = 0.0

func teleport_to_player():
	if player:
		global_transform.origin = player.global_transform.origin
