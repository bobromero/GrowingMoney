extends Control

var startText: String = "Start"
var tryAgainText: String = "Try Again!"

func _process(delta: float) -> void:
	UpdateText()

func UpdateText():
	if GameManager.deaths > 0:
		$VBoxContainer/StartButton.text = tryAgainText
		$VBoxContainer/Label.text = str("Deaths: ", GameManager.deaths) + str("\tWave: ", GameManager.waveNumber)
	else:
		$VBoxContainer/StartButton.text = startText


func _on_start_button_pressed() -> void:
	GameManager.StartGame()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
