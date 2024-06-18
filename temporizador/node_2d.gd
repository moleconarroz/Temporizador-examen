extends CanvasLayer

var is_timer = true

var minutes = 0 
var seconds = 0
var decimals = 0

var mode_label = 'Timer'

func update_label():
	$Clable.text = str(decimals) 
	$TimeLabel.text = '%02d:%02d'%[minutes,seconds]

func _on_mode_button_pressed():
	if $MainTimer.is_stopped():
		minutes = 0
		seconds = 0
		decimals = 0 
		is_timer = !is_timer
		if is_timer == true:
			mode_label = 'TIMER'
		else:
			mode_label = 'STOPWATCH'
	update_label()
	$ModeLabel.text = mode_label


func _on_start_button_pressed():
	if $MainTimer.is_stopped():
		$MainTimer.start()
		$StatusLabel.text = 'RUNNING'
	else:
		$MainTimer.stop()
		$StatusLabel.text = 'STOPPED'


func update_stopwatch():
	decimals += 1
	if decimals >= 10:
		decimals = 0
		seconds += 1
	if seconds >= 60:
		seconds = 0
		minutes += 1
	if minutes >= 59:
		seconds = 59
		minutes = 59
		decimals = 9
		$StatusLabel.text = 'STOPPED'
		$MainTimer.stop()
		$StopTimerSound.play()
	update_label()

func update_timer():
	decimals -= 1
	if decimals < 0:
		decimals = 9
		seconds -= 1
	if seconds < 0:
		seconds = 59
		minutes -= 1
	if minutes < 0:
		minutes = 0
		seconds = 0
		decimals = 0
		$StatusLabel.text = 'STOPPED'
		$MainTimer.stop()
	update_label()

func _on_main_timer_timeout():
	if is_timer == false:
		update_stopwatch()
	else:
		update_timer()


func _on_sec_button_pressed():
	if $MainTimer.is_stopped() and is_timer == true:
		seconds += 1
		if seconds > 59:
			seconds = 0
		decimals = 0
		update_label()
 


func _on_min_button_pressed():
	if $MainTimer.is_stopped() and is_timer == true:
		minutes += 1
		if minutes > 59:
			minutes = 0
		decimals = 0
		update_label()


func _on_clear_button_pressed():
	if $MainTimer.is_stopped():
		minutes = 0
		seconds = 0
		decimals = 0
		update_label()

