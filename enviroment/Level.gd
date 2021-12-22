extends Spatial


var levels = [
	"res://Environment/Level01.tscn",
	"res://Environment/Level02.tscn"
]

export var current_level = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DeathZone_body_entered(body):
	if body.name == "Ball" :
		get_tree().reload_current_scene()


func _on_VictoryZone_body_entered(body):
	if body.name == "Ball" :
		current_level += 1
		if current_level < levels.size() :
			print("Load level", levels[current_level])
			get_tree().change_scene(levels[current_level])
