extends Control

var startText: String = "Start"
var tryAgainText: String = "Try Again!"

func _process(_delta: float) -> void:
	UpdateText()

func UpdateText():
	if GameManager.deaths > 0:
		$VBoxContainer/StartButton.text = tryAgainText
		$VBoxContainer/Label.text = str("Deaths: ", GameManager.deaths) + str("\nWave: ", GameManager.waveNumber) + str("\nScore: " , GameManager.LastScore)
	else:
		$VBoxContainer/StartButton.text = startText


func _on_start_button_pressed() -> void:
	GameManager.StartGame()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
