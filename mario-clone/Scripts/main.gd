extends Node

@onready var hud = $Hud
@onready var player = $Player

var coins = 0
var lives = 3

func _ready():
	player.damage_taken.connect(Callable(self, "_on_player_damage"))
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.add_point.connect(Callable(self, "_on_coin_collected"))
	get_tree().connect("node_added", Callable(self, "_on_node_added"))
	_update_hud()

func _on_node_added(node):
	if node.is_in_group("coins"):
		node.add_point.connect(Callable(self, "_on_coin_collected"))

func _on_coin_collected():
	coins += 1
	_update_hud()

func _on_player_damage():
	lives -= 1
	_update_hud()
	if lives <= 0:
		get_tree().reload_current_scene()

func _update_hud():
	if hud:
		hud.update_hud(coins, lives)
