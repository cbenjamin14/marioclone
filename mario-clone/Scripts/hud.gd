extends CanvasLayer

func _ready():
	update_hud(0,3)

func update_hud(coins, lives):
	$MarginContainer/VBoxContainer/CoinsLabel.text = "Coins: " + str(coins)
	$MarginContainer/VBoxContainer/LivesLabel.text = "Lives: " + str(lives)
