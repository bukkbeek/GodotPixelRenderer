extends Node3D
@export var renderer: Node3D


@onready var x_pos_spin: SpinBox = %XPosSpin
@onready var y_pos_spin: SpinBox = %YPosSpin
@onready var z_pos_spin: SpinBox = %ZPosSpin

@onready var camera: Camera3D = %Camera
@onready var zoom_spin: SpinBox = %CameraZoomSpin
@onready var reset_button: Button = %PosResetButton

@onready var x_rot_spin: SpinBox = %XRotSpin
@onready var y_rot_spin: SpinBox = %YRotSpin
@onready var z_rot_spin: SpinBox = %ZRotSpin
@onready var button_up: Button = %Button_Up
@onready var button_down: Button = %Button_Down
@onready var button_left: Button = %Button_Left
@onready var button_right: Button = %Button_Right
@onready var rot_reset_button: Button = %RotResetButton
@onready var zoom_reset_button: Button = %ZoomResetButton

@onready var models_spawner: Node3D = %ModelsSpawner
@onready var model_rotate_slider: HSlider = %ModelRotationSlider
@onready var model_rotate_spinbox: SpinBox = %ModelRotationSpinBox

@onready var steps_360_render: SpinBox = %Step360
@onready var button_360_render: Button = %Export360
@onready var button_360_render_abort: Button = %Export360Abort

var current_step: int = 0
var total_steps: int = 0
var angle_increment: float = 0.0
var base_prefix: String = ""
var is_exporting_360: bool = false
var is_export_aborted: bool = false

const ADJUSTMENT_CONFIG_FILE= "user://adjustment_config.cfg"

func _ready():
	# Set default values
	#_reset_to_defaults()
	_initialize_controls()
	_apply_default_settings()
	
	# Connect spinbox value changes to update position and camera
	x_pos_spin.value_changed.connect(_on_position_changed)
	y_pos_spin.value_changed.connect(_on_position_changed)
	z_pos_spin.value_changed.connect(_on_position_changed)
	zoom_spin.value_changed.connect(_on_zoom_changed)
	reset_button.pressed.connect(_reset_to_defaults)
	zoom_reset_button.pressed.connect(_reset_zoom)
	
	# Connect rotation spinboxes to update rotation
	x_rot_spin.value_changed.connect(_on_rotation_changed)
	y_rot_spin.value_changed.connect(_on_rotation_changed)
	z_rot_spin.value_changed.connect(_on_rotation_changed)
	
	# Connect preset rotation buttons
	button_up.pressed.connect(_on_rotate_up)
	button_down.pressed.connect(_on_rotate_down)
	button_left.pressed.connect(_on_rotate_left)
	button_right.pressed.connect(_on_rotate_right)
	rot_reset_button.pressed.connect(_reset_rotation)
	
	model_rotate_slider.value_changed.connect(_on_model_rotated)
	model_rotate_spinbox.value_changed.connect(_on_model_rotated)
	
	button_360_render.pressed.connect(_on_360_export_pressed)
	button_360_render_abort.pressed.connect(_on_360_export_abort_pressed)
	
	renderer.single_export_finished.connect(_on_single_export_finished)
	
func _on_360_export_abort_pressed():
	if is_exporting_360:
		is_export_aborted = true
		
func _on_360_export_pressed():
	if is_exporting_360:
		return
		
	angle_increment = steps_360_render.value
	if angle_increment == 0:
		return

	is_exporting_360 = true
	is_export_aborted = false
	current_step = 0
	total_steps = int(360.0 / angle_increment)
	base_prefix = renderer.prefix_text.text.strip_edges()
	
	process_next_export_step()

func process_next_export_step():
	if current_step >= total_steps or is_export_aborted:
		print("Экспорт 360 завершен или прерван.")
		is_exporting_360 = false
		is_export_aborted = false
		renderer.prefix_text.text = base_prefix
		return

	var current_angle = current_step * angle_increment
	
	model_rotate_slider.value = current_angle
	# Wait extra frames for rotation to fully apply and viewport to render
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	if base_prefix.is_empty():
		renderer.prefix_text.text = "frame_" + str(current_angle)
	else:
		renderer.prefix_text.text = base_prefix + "_" + str(current_angle)
	
	if renderer.export_directory == "":
		renderer.start_export()
		while renderer.export_directory == "":
			await get_tree().process_frame
	
	renderer.start_export()
	
const DEFAULT_SETTINGS = {
	"position": {
		"x": 0.0,
		"y": 0.0,
		"z": 0.0
	},
	"rotation": {
		"x": 0.0,
		"y": 0.0,
		"z": 0.0
	},
	"zoom": {
		"value": 4.0
	}
}

var infinity = 999999999
func _initialize_controls():
	# Initialize spin boxes with proper ranges
	x_pos_spin.min_value = -infinity
	x_pos_spin.max_value = infinity
	x_pos_spin.step = 0.1
	
	y_pos_spin.min_value = -infinity
	y_pos_spin.max_value = infinity
	y_pos_spin.step = 0.1
	
	z_pos_spin.min_value = -infinity
	z_pos_spin.max_value = infinity
	z_pos_spin.step = 0.1
	
	x_rot_spin.min_value = -infinity
	x_rot_spin.max_value = infinity
	x_rot_spin.step = 0.1
	
	y_rot_spin.min_value = -infinity
	y_rot_spin.max_value = infinity
	y_rot_spin.step = 0.1
	
	z_rot_spin.min_value = -infinity
	z_rot_spin.max_value = infinity
	z_rot_spin.step = 0.1

func _apply_default_settings():
	var config = ConfigFile.new()
	config.load(ADJUSTMENT_CONFIG_FILE)
	
	# Apply default settings to lights
	x_pos_spin.value = config.get_value("position", "x", DEFAULT_SETTINGS.position.x)
	y_pos_spin.value = config.get_value("position", "y", DEFAULT_SETTINGS.position.y)
	z_pos_spin.value = config.get_value("position", "z", DEFAULT_SETTINGS.position.z)
	
	x_rot_spin.value = config.get_value("rotation", "x", DEFAULT_SETTINGS.rotation.x)
	y_rot_spin.value = config.get_value("rotation", "y", DEFAULT_SETTINGS.rotation.y)
	z_rot_spin.value = config.get_value("rotation", "z", DEFAULT_SETTINGS.rotation.z)
	
	zoom_spin.value = config.get_value("zoom", "value", DEFAULT_SETTINGS.zoom.value)
	
	_on_position_changed(0)
	_on_rotation_changed(0)
	_on_zoom_changed(zoom_spin.value)
	
func _save_settings():
	var config = ConfigFile.new()
	
	# Save Key Light settings
	config.set_value("position", "x", x_pos_spin.value)
	config.set_value("position", "y", y_pos_spin.value)
	config.set_value("position", "z", z_pos_spin.value)
	
	config.set_value("rotation", "x", x_rot_spin.value)
	config.set_value("rotation", "y", y_rot_spin.value)
	config.set_value("rotation", "z", z_rot_spin.value)
	
	config.set_value("zoom", "value", zoom_spin.value)
	
	var error = config.save(ADJUSTMENT_CONFIG_FILE)
	if error != OK:
		print("Failed to save adjustment settings: ", error)
	
func _on_single_export_finished():
	# Renderer сообщил, что закончил. Переходим к следующему шагу.
	current_step += 1
	# Wait extra frames to ensure viewport has fully rendered before next rotation
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	process_next_export_step()

func _on_model_rotated(_value):
	model_rotate_spinbox.value = _value;
	model_rotate_slider.value = _value;
	var rotation_in_radians = deg_to_rad(_value)
	models_spawner.rotation.y = rotation_in_radians

func _on_position_changed(_value):
	# Update position when any spinbox value changes
	position = Vector3(x_pos_spin.value, y_pos_spin.value, z_pos_spin.value)
	_save_settings()

func _on_rotation_changed(_value):
	# Update rotation when any rotation spinbox value changes
	rotation_degrees = Vector3(x_rot_spin.value, y_rot_spin.value, z_rot_spin.value)
	_save_settings()

func _on_rotate_up():
	# Rotate up by 90 degrees on X axis
	x_rot_spin.value += 90.0
	_on_rotation_changed(0)

func _on_rotate_down():
	# Rotate down by 90 degrees on X axis
	x_rot_spin.value -= 90.0
	_on_rotation_changed(0)

func _on_rotate_left():
	# Rotate left by 90 degrees on Y axis
	y_rot_spin.value -= 90.0
	_on_rotation_changed(0)

func _on_rotate_right():
	# Rotate right by 90 degrees on Y axis
	y_rot_spin.value += 90.0
	_on_rotation_changed(0)

func _reset_rotation():
	# Reset rotation to (0,0,0)
	x_rot_spin.value = 0.0
	y_rot_spin.value = 0.0
	z_rot_spin.value = 0.0
	rotation_degrees = Vector3(0.0, 0.0, 0.0)
	_save_settings()

func _on_zoom_changed(_value):
	if _value > 0.0:
		camera.size = _value
		zoom_spin.value = _value
		_save_settings()

func _reset_to_defaults():
	# Set default values: position (0,0,0)
	x_pos_spin.value = 0.0
	y_pos_spin.value = 0.0
	z_pos_spin.value = 0.0

	# Update position
	position = Vector3(0.0, 0.0, 0.0)
	_save_settings()


func _reset_zoom():
	# Reset zoom to default value
	zoom_spin.value = 4.0
	camera.size = 4.0
	_save_settings()
