extends Node

const PIXEL_MATERIAL = preload("res://PixelRenderer/data/PixelMaterial.tres")
const CONFIG_FILE_PATH = "user://material_config.cfg"
const PRESETS_FILE_PATH = "user://material_presets.cfg"
const CUSTOM_COLORS_FILE_PATH = "user://custom_colors.cfg"
const PIXELART_STYLIZER = preload("res://PixelRenderer/data/pixelart_stylizer.tres")
@onready var color_preset_option_button: OptionButton = %ColorPresetOptionButton


# UI Components
@onready var target_pixel_count_spin: SpinBox = %Resolution
@onready var color_steps_spin: SpinBox = %ColorStepsSpin
@onready var edge_strength_slider: HSlider = %EdgeStrengthSlider
@onready var sharpness_slider: HSlider = %SharpnessSlider
@onready var hue_shift_slider: HSlider = %HueShiftSlider
@onready var saturation_slider: HSlider = %SaturationSlider
@onready var value_slider: HSlider = %ValueSlider
@onready var contrast_slider: HSlider = %ContrastSlider
@onready var gamma_slider: HSlider = %GammaSlider
@onready var brightness_slider: HSlider = %BrightnessSlider
@onready var post_process_outline: SpinBox = %PostProcessOutline
@onready var shadow_strength_color_picker: ColorPickerButton = %ShadowStrengthColorPicker
@onready var highlight_strength_color_picker: ColorPickerButton = %HighlightStrengthColorPicker
@onready var shadow_strength_slider: HSlider = %ShadowStrengthSlider
@onready var highlight_strength_slider: HSlider = %HighlightStrengthSlider
@onready var outline_spin: SpinBox = %OutlineSpinBox
@onready var outline_color_picker: ColorPickerButton = %OutlineColorPicker
@onready var use_palette_check_box: CheckButton = %UsePaletteCheckButton
@onready var use_palette_color_1: ColorPickerButton = %UsePaletteColor1
@onready var use_palette_color_2: ColorPickerButton = %UsePaletteColor2
@onready var use_palette_color_3: ColorPickerButton = %UsePaletteColor3
@onready var use_palette_color_4: ColorPickerButton = %UsePaletteColor4
@onready var use_palette_color_5: ColorPickerButton = %UsePaletteColor5
@onready var use_palette_color_6: ColorPickerButton = %UsePaletteColor6
@onready var use_palette_color_7: ColorPickerButton = %UsePaletteColor7
@onready var use_palette_color_8: ColorPickerButton = %UsePaletteColor8

@onready var reset_material_button: Button = %ResetMaterialButton

@onready var dither_amount_slider: HSlider = %DitherAmountSlider
@onready var dither_blend_slider: HSlider = %DitherBlendSlider
@onready var dither_threshold_slider: HSlider = %DitherThresholdSlider
@onready var dither_sensitivity_slider: HSlider = %DitherSensitivitySlider
@onready var dither_dot_size_spin: SpinBox = %DitherDotSizeSpin
@onready var dither_dot_color: ColorPickerButton = %DitherDotColor

# Preset UI Components
@onready var preset_option_button: OptionButton = %PresetOptionButton
@onready var search_text_line_edit: LineEdit = %SearchTextLineEdit
@onready var save_preset_button: Button = %SavePresetButton
@onready var delete_preset_button: Button = %DeletePresetButton

# Color sampling button
@onready var sample_colors_button: Button = %SampleColorsButton
@onready var sub_viewport: SubViewport = %SubViewport

@onready var pixel_renderer_node: TextureRect = %PixelCanvas

# Preset management variables
var all_presets: Dictionary = {}
var filtered_presets: Array[String] = []
var current_preset_name: String = ""
var is_loading_preset: bool = false

# SLso8 palette colors
const SLSO8_COLORS = [
	Color(0.051, 0.169, 0.271, 1.0),  # #0d2b45
	Color(0.125, 0.235, 0.337, 1.0),  # #203c56
	Color(0.329, 0.306, 0.408, 1.0),  # #544e68
	Color(0.553, 0.412, 0.478, 1.0),  # #8d697a
	Color(0.816, 0.506, 0.349, 1.0),  # #d08159
	Color(1.0, 0.667, 0.369, 1.0),    # #ffaa5e
	Color(1.0, 0.831, 0.639, 1.0),    # #ffd4a3
	Color(1.0, 0.925, 0.839, 1.0),    # #ffecd6
]

# Default values for reset functionality
const DEFAULT_VALUES = {
	"target_pixel_count": 256,  # Match shader default
	"color_steps": 8,
	"edge_strength": 0.5,
	"sharpness": 1.0,
	"hue_shift": 0.0,
	"saturation": 1.0,
	"value": 1.0,
	"contrast": 1.0,
	"gamma": 1.0,
	"brightness": 0.0,
	"outline": 0.0,
	"outline_color": Color(0.0, 0.0, 0.0, 1.0),
	"post_process_outline": 0.0,
	"shadow_strength": 0.4,
	"highlight_strength": 0.1,
	"shadow_color": Color(0.0, 0.0, 0.0, 1.0),
	"highlight_color": Color(1.0, 1.0, 1.0, 1.0),
	"use_palette": true,  # Match shader default
	"palette_color_1": Color(0.051, 0.169, 0.271, 1.0),
	"palette_color_2": Color(0.125, 0.235, 0.337, 1.0),
	"palette_color_3": Color(0.329, 0.306, 0.408, 1.0),
	"palette_color_4": Color(0.553, 0.412, 0.478, 1.0),
	"palette_color_5": Color(0.816, 0.506, 0.349, 1.0),
	"palette_color_6": Color(1.0, 0.667, 0.369, 1.0),
	"palette_color_7": Color(1.0, 0.831, 0.639, 1.0),
	"palette_color_8": Color(1.0, 0.925, 0.839, 1.0),
	"dither_amount": 0.5,  # Match shader default
	"dither_blend": 1.0,   # Match shader default
	"dither_threshold": 0.5,
	"shadow_sensitivity": 1.0,
	"dot_size": 1.0,
	"dither_color": Color(0.0, 0.0, 0.0, 1.0)
}

# Reference to built-in presets
var BUILTIN_PRESETS: Dictionary
var BUILTIN_COLOR_PRESETS: Dictionary

# Color preset management variables
var all_color_presets: Dictionary = {}
var filtered_color_presets: Array[String] = []
var current_color_preset_name: String = ""
var is_loading_color_preset: bool = false

# Reference to the main PixelRenderer node for accessing rendered image
@onready var pixel_renderer: TextureRect = %PixelCanvas

# Console output function
func _update_console(message: String):
	if pixel_renderer_node and pixel_renderer_node.has_method("_update_progress"):
		pixel_renderer_node._update_progress(message)
	else:
		print(message)  # Fallback to print if console unavailable

func _ready():
	
	# Load built-in presets first
	BUILTIN_PRESETS = BuiltinPresets.get_all_presets()
	BUILTIN_COLOR_PRESETS = BuiltinColorPresets.get_all_color_presets()
	

	
	# Load saved values or defaults
	_load_saved_values()
	
	# Ensure palette is always disabled at startup
	use_palette_check_box.button_pressed = false
	
	# Initialize presets
	_initialize_presets()
	_initialize_color_presets()
	
	# Connect UI signals
	_connect_signals()
	
	# Apply initial values to shader
	_apply_all_values()

func _initialize_presets():
	# Load presets from file
	_load_presets()
	
	# Update preset UI
	_update_preset_list()
	
	# Set default selection
	if all_presets.has("Default"):
		_select_preset("Default")

func _initialize_color_presets():
	# Start with built-in color presets
	all_color_presets = BUILTIN_COLOR_PRESETS.duplicate(true)
	
	# Load saved custom colors
	_load_custom_colors()
	
	# Update color preset UI
	_update_color_preset_list()
	
	# Select the saved color preset, fallback to Custom if not found
	if all_color_presets.has(current_color_preset_name):
		_select_color_preset(current_color_preset_name)
	elif all_color_presets.has("Custom"):
		_select_color_preset("Custom")

func _load_presets():
	var config = ConfigFile.new()
	var err = config.load(PRESETS_FILE_PATH)
	
	# Start with built-in presets
	all_presets = BUILTIN_PRESETS.duplicate(true)
	
	if err == OK:
		# Load user presets
		var preset_names = config.get_sections()
		for preset_name in preset_names:
			var preset_data = {}
			for key in DEFAULT_VALUES.keys():
				preset_data[key] = config.get_value(preset_name, key, DEFAULT_VALUES[key])
			all_presets[preset_name] = preset_data
	
	_update_console("Loaded " + str(all_presets.size()) + " presets")

func _save_presets():
	var config = ConfigFile.new()
	
	# Save only user presets (not built-in ones)
	for preset_name in all_presets.keys():
		if not BUILTIN_PRESETS.has(preset_name):
			var preset_data = all_presets[preset_name]
			for key in preset_data.keys():
				config.set_value(preset_name, key, preset_data[key])
	
	config.save(PRESETS_FILE_PATH)
	_update_console("Presets saved to " + PRESETS_FILE_PATH)

func _update_preset_list():
	var search_text = search_text_line_edit.text.to_lower()
	filtered_presets.clear()
	
	# Filter presets based on search text
	for preset_name in all_presets.keys():
		if search_text.is_empty() or preset_name.to_lower().contains(search_text):
			filtered_presets.append(preset_name)
	
	# Sort presets (built-in first, then alphabetically)
	filtered_presets.sort_custom(_compare_presets)
	
	# Update option button
	preset_option_button.clear()
	for i in range(filtered_presets.size()):
		var preset_name = filtered_presets[i]
		var display_name = preset_name
		if BUILTIN_PRESETS.has(preset_name):
			display_name = "★ " + preset_name
		preset_option_button.add_item(display_name)
		
		# Select current preset if it matches
		if preset_name == current_preset_name:
			preset_option_button.selected = i

func _compare_presets(a: String, b: String) -> bool:
	# Built-in presets come first
	var a_builtin = BUILTIN_PRESETS.has(a)
	var b_builtin = BUILTIN_PRESETS.has(b)
	
	if a_builtin and not b_builtin:
		return true
	elif not a_builtin and b_builtin:
		return false
	else:
		return a < b

func _select_preset(preset_name: String):
	if not all_presets.has(preset_name):
		return
	
	current_preset_name = preset_name
	is_loading_preset = true
	
	var preset_data = all_presets[preset_name]
	
	# Apply preset values to UI controls
	target_pixel_count_spin.value = preset_data.get("target_pixel_count", DEFAULT_VALUES.target_pixel_count)
	color_steps_spin.value = preset_data.get("color_steps", DEFAULT_VALUES.color_steps)
	edge_strength_slider.value = preset_data.get("edge_strength", DEFAULT_VALUES.edge_strength)
	sharpness_slider.value = preset_data.get("sharpness", DEFAULT_VALUES.sharpness)
	hue_shift_slider.value = preset_data.get("hue_shift", DEFAULT_VALUES.hue_shift)
	saturation_slider.value = preset_data.get("saturation", DEFAULT_VALUES.saturation)
	value_slider.value = preset_data.get("value", DEFAULT_VALUES.value)
	contrast_slider.value = preset_data.get("contrast", DEFAULT_VALUES.contrast)
	gamma_slider.value = preset_data.get("gamma", DEFAULT_VALUES.gamma)
	brightness_slider.value = preset_data.get("brightness", DEFAULT_VALUES.brightness)
	outline_spin.value = preset_data.get("outline", DEFAULT_VALUES.outline)
	outline_color_picker.color = preset_data.get("outline_color", DEFAULT_VALUES.outline_color)
	use_palette_check_box.button_pressed = preset_data.get("use_palette", DEFAULT_VALUES.use_palette)
	
	# Apply palette colors
	use_palette_color_1.color = preset_data.get("palette_color_1", DEFAULT_VALUES.palette_color_1)
	use_palette_color_2.color = preset_data.get("palette_color_2", DEFAULT_VALUES.palette_color_2)
	use_palette_color_3.color = preset_data.get("palette_color_3", DEFAULT_VALUES.palette_color_3)
	use_palette_color_4.color = preset_data.get("palette_color_4", DEFAULT_VALUES.palette_color_4)
	use_palette_color_5.color = preset_data.get("palette_color_5", DEFAULT_VALUES.palette_color_5)
	use_palette_color_6.color = preset_data.get("palette_color_6", DEFAULT_VALUES.palette_color_6)
	use_palette_color_7.color = preset_data.get("palette_color_7", DEFAULT_VALUES.palette_color_7)
	use_palette_color_8.color = preset_data.get("palette_color_8", DEFAULT_VALUES.palette_color_8)
	
	# Apply PixelArt Stylizer parameters
	post_process_outline.value = preset_data.get("post_process_outline", DEFAULT_VALUES.post_process_outline)
	shadow_strength_slider.value = preset_data.get("shadow_strength", DEFAULT_VALUES.shadow_strength)
	highlight_strength_slider.value = preset_data.get("highlight_strength", DEFAULT_VALUES.highlight_strength)
	shadow_strength_color_picker.color = preset_data.get("shadow_color", DEFAULT_VALUES.shadow_color)
	highlight_strength_color_picker.color = preset_data.get("highlight_color", DEFAULT_VALUES.highlight_color)
	
	# Switch color preset to Custom when loading main preset
	if current_color_preset_name != "Custom":
		_switch_to_custom_preset()
	
	# Apply dithering parameters
	dither_amount_slider.value = preset_data.get("dither_amount", DEFAULT_VALUES.dither_amount)
	dither_blend_slider.value = preset_data.get("dither_blend", DEFAULT_VALUES.dither_blend)
	dither_threshold_slider.value = preset_data.get("dither_threshold", DEFAULT_VALUES.dither_threshold)
	dither_sensitivity_slider.value = preset_data.get("shadow_sensitivity", DEFAULT_VALUES.shadow_sensitivity)
	dither_dot_size_spin.value = preset_data.get("dot_size", DEFAULT_VALUES.dot_size)
	dither_dot_color.color = preset_data.get("dither_color", DEFAULT_VALUES.dither_color)
	
	# Apply to shader
	_apply_all_values()
	
	is_loading_preset = false
	
	_update_console("Loaded preset: " + preset_name)

func _save_current_as_preset(preset_name: String):
	var preset_data = _get_current_values()
	all_presets[preset_name] = preset_data
	_save_presets()
	_update_preset_list()
	
	# Select the newly saved preset
	current_preset_name = preset_name
	_update_preset_selection()
	
	_update_console("Saved preset: " + preset_name)

func _get_current_values() -> Dictionary:
	return {
		"target_pixel_count": int(target_pixel_count_spin.value),
		"color_steps": int(color_steps_spin.value),
		"edge_strength": edge_strength_slider.value,
		"sharpness": sharpness_slider.value,
		"hue_shift": hue_shift_slider.value,
		"saturation": saturation_slider.value,
		"value": value_slider.value,
		"contrast": contrast_slider.value,
		"gamma": gamma_slider.value,
		"brightness": brightness_slider.value,
		"outline": outline_spin.value,
		"outline_color": outline_color_picker.color,
		"post_process_outline": post_process_outline.value,
		"shadow_strength": shadow_strength_slider.value,
		"highlight_strength": highlight_strength_slider.value,
		"shadow_color": shadow_strength_color_picker.color,
		"highlight_color": highlight_strength_color_picker.color,
		"use_palette": use_palette_check_box.button_pressed,
		"palette_color_1": use_palette_color_1.color,
		"palette_color_2": use_palette_color_2.color,
		"palette_color_3": use_palette_color_3.color,
		"palette_color_4": use_palette_color_4.color,
		"palette_color_5": use_palette_color_5.color,
		"palette_color_6": use_palette_color_6.color,
		"palette_color_7": use_palette_color_7.color,
		"palette_color_8": use_palette_color_8.color,
		"dither_amount": dither_amount_slider.value,
		"dither_blend": dither_blend_slider.value,
		"dither_threshold": dither_threshold_slider.value,
		"shadow_sensitivity": dither_sensitivity_slider.value,
		"dot_size": dither_dot_size_spin.value,
		"dither_color": dither_dot_color.color
	}

func _delete_preset(preset_name: String):
	if BUILTIN_PRESETS.has(preset_name):
		_update_console("Cannot delete built-in preset: " + preset_name)
		return
	
	if all_presets.has(preset_name):
		all_presets.erase(preset_name)
		_save_presets()
		_update_preset_list()
		
		# If we deleted the current preset, select Default
		if current_preset_name == preset_name:
			_select_preset("Default")
		
		_update_console("Deleted preset: " + preset_name)

func _generate_preset_name() -> String:
	var base_name = "Preset"
	var counter = 1
	
	while all_presets.has(base_name + " " + str(counter)):
		counter += 1
	
	return base_name + " " + str(counter)

func _update_preset_selection():
	for i in range(filtered_presets.size()):
		if filtered_presets[i] == current_preset_name:
			preset_option_button.selected = i
			break

# Color preset management functions
func _update_color_preset_list():
	filtered_color_presets.clear()
	
	# Add all color presets (they're all built-in for now)
	for preset_name in all_color_presets.keys():
		filtered_color_presets.append(preset_name)
	
	# Sort presets (Custom first, then alphabetically)
	filtered_color_presets.sort_custom(_compare_color_presets)
	
	# Update option button
	color_preset_option_button.clear()
	for i in range(filtered_color_presets.size()):
		var preset_name = filtered_color_presets[i]
		color_preset_option_button.add_item(preset_name)
		
		# Select current preset if it matches
		if preset_name == current_color_preset_name:
			color_preset_option_button.selected = i

func _select_color_preset(preset_name: String):
	if not all_color_presets.has(preset_name):
		return
	
	current_color_preset_name = preset_name
	is_loading_color_preset = true
	
	var preset_data = all_color_presets[preset_name]
	
	# Apply color preset to palette colors only
	use_palette_color_1.color = preset_data.get("palette_color_1", DEFAULT_VALUES.palette_color_1)
	use_palette_color_2.color = preset_data.get("palette_color_2", DEFAULT_VALUES.palette_color_2)
	use_palette_color_3.color = preset_data.get("palette_color_3", DEFAULT_VALUES.palette_color_3)
	use_palette_color_4.color = preset_data.get("palette_color_4", DEFAULT_VALUES.palette_color_4)
	use_palette_color_5.color = preset_data.get("palette_color_5", DEFAULT_VALUES.palette_color_5)
	use_palette_color_6.color = preset_data.get("palette_color_6", DEFAULT_VALUES.palette_color_6)
	use_palette_color_7.color = preset_data.get("palette_color_7", DEFAULT_VALUES.palette_color_7)
	use_palette_color_8.color = preset_data.get("palette_color_8", DEFAULT_VALUES.palette_color_8)
	
	# Enable palette mode when applying color preset
	use_palette_check_box.button_pressed = true
	
	# Apply to shader
	_apply_all_values()
	
	is_loading_color_preset = false
	
	_update_console("Loaded color preset: " + preset_name)

func _compare_color_presets(a: String, b: String) -> bool:
	# "Custom" comes first
	if a == "Custom" and b != "Custom":
		return true
	elif a != "Custom" and b == "Custom":
		return false
	else:
		return a < b

func _update_color_preset_selection():
	for i in range(filtered_color_presets.size()):
		if filtered_color_presets[i] == current_color_preset_name:
			color_preset_option_button.selected = i
			break

func _load_custom_colors():
	var config = ConfigFile.new()
	var err = config.load(CUSTOM_COLORS_FILE_PATH)
	
	if err == OK:
		# Load saved custom colors
		var custom_colors = {
			"palette_color_1": config.get_value("custom", "palette_color_1", DEFAULT_VALUES.palette_color_1),
			"palette_color_2": config.get_value("custom", "palette_color_2", DEFAULT_VALUES.palette_color_2),
			"palette_color_3": config.get_value("custom", "palette_color_3", DEFAULT_VALUES.palette_color_3),
			"palette_color_4": config.get_value("custom", "palette_color_4", DEFAULT_VALUES.palette_color_4),
			"palette_color_5": config.get_value("custom", "palette_color_5", DEFAULT_VALUES.palette_color_5),
			"palette_color_6": config.get_value("custom", "palette_color_6", DEFAULT_VALUES.palette_color_6),
			"palette_color_7": config.get_value("custom", "palette_color_7", DEFAULT_VALUES.palette_color_7),
			"palette_color_8": config.get_value("custom", "palette_color_8", DEFAULT_VALUES.palette_color_8),
		}
		all_color_presets["Custom"] = custom_colors
		_update_console("Loaded custom colors from file")
	else:
		_update_console("No custom colors file found, using defaults")

func _save_custom_colors():
	var config = ConfigFile.new()
	var custom_colors = all_color_presets["Custom"]
	
	# Save custom colors to file
	config.set_value("custom", "palette_color_1", custom_colors.palette_color_1)
	config.set_value("custom", "palette_color_2", custom_colors.palette_color_2)
	config.set_value("custom", "palette_color_3", custom_colors.palette_color_3)
	config.set_value("custom", "palette_color_4", custom_colors.palette_color_4)
	config.set_value("custom", "palette_color_5", custom_colors.palette_color_5)
	config.set_value("custom", "palette_color_6", custom_colors.palette_color_6)
	config.set_value("custom", "palette_color_7", custom_colors.palette_color_7)
	config.set_value("custom", "palette_color_8", custom_colors.palette_color_8)
	
	config.save(CUSTOM_COLORS_FILE_PATH)
	_update_console("Custom colors saved to " + CUSTOM_COLORS_FILE_PATH)

func _switch_to_custom_preset():
	# Update the Custom preset with current colors
	var current_colors = {
		"palette_color_1": use_palette_color_1.color,
		"palette_color_2": use_palette_color_2.color,
		"palette_color_3": use_palette_color_3.color,
		"palette_color_4": use_palette_color_4.color,
		"palette_color_5": use_palette_color_5.color,
		"palette_color_6": use_palette_color_6.color,
		"palette_color_7": use_palette_color_7.color,
		"palette_color_8": use_palette_color_8.color,
	}
	all_color_presets["Custom"] = current_colors
	
	# Save custom colors to file
	_save_custom_colors()
	
	# Switch to Custom preset without triggering color changes
	current_color_preset_name = "Custom"
	_update_color_preset_selection()

func _load_saved_values():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	
	if err == OK:
		# Load saved values
		target_pixel_count_spin.value = config.get_value("material", "target_pixel_count", DEFAULT_VALUES.target_pixel_count)
		color_steps_spin.value = config.get_value("material", "color_steps", DEFAULT_VALUES.color_steps)
		edge_strength_slider.value = config.get_value("material", "edge_strength", DEFAULT_VALUES.edge_strength)
		sharpness_slider.value = config.get_value("material", "sharpness", DEFAULT_VALUES.sharpness)
		hue_shift_slider.value = config.get_value("material", "hue_shift", DEFAULT_VALUES.hue_shift)
		saturation_slider.value = config.get_value("material", "saturation", DEFAULT_VALUES.saturation)
		value_slider.value = config.get_value("material", "value", DEFAULT_VALUES.value)
		contrast_slider.value = config.get_value("material", "contrast", DEFAULT_VALUES.contrast)
		gamma_slider.value = config.get_value("material", "gamma", DEFAULT_VALUES.gamma)
		brightness_slider.value = config.get_value("material", "brightness", DEFAULT_VALUES.brightness)
		outline_spin.value = config.get_value("material", "outline", DEFAULT_VALUES.outline)
		outline_color_picker.color = config.get_value("material", "outline_color", DEFAULT_VALUES.outline_color)
		post_process_outline.value = config.get_value("material", "post_process_outline", DEFAULT_VALUES.post_process_outline)
		shadow_strength_slider.value = config.get_value("material", "shadow_strength", DEFAULT_VALUES.shadow_strength)
		highlight_strength_slider.value = config.get_value("material", "highlight_strength", DEFAULT_VALUES.highlight_strength)
		shadow_strength_color_picker.color = config.get_value("material", "shadow_color", DEFAULT_VALUES.shadow_color)
		highlight_strength_color_picker.color = config.get_value("material", "highlight_color", DEFAULT_VALUES.highlight_color)
		use_palette_check_box.button_pressed = config.get_value("material", "use_palette", DEFAULT_VALUES.use_palette)
		
		# Load palette colors
		use_palette_color_1.color = config.get_value("material", "palette_color_1", DEFAULT_VALUES.palette_color_1)
		use_palette_color_2.color = config.get_value("material", "palette_color_2", DEFAULT_VALUES.palette_color_2)
		use_palette_color_3.color = config.get_value("material", "palette_color_3", DEFAULT_VALUES.palette_color_3)
		use_palette_color_4.color = config.get_value("material", "palette_color_4", DEFAULT_VALUES.palette_color_4)
		use_palette_color_5.color = config.get_value("material", "palette_color_5", DEFAULT_VALUES.palette_color_5)
		use_palette_color_6.color = config.get_value("material", "palette_color_6", DEFAULT_VALUES.palette_color_6)
		use_palette_color_7.color = config.get_value("material", "palette_color_7", DEFAULT_VALUES.palette_color_7)
		use_palette_color_8.color = config.get_value("material", "palette_color_8", DEFAULT_VALUES.palette_color_8)
		
		# Load dithering parameters
		dither_amount_slider.value = config.get_value("material", "dither_amount", DEFAULT_VALUES.dither_amount)
		dither_blend_slider.value = config.get_value("material", "dither_blend", DEFAULT_VALUES.dither_blend)
		dither_threshold_slider.value = config.get_value("material", "dither_threshold", DEFAULT_VALUES.dither_threshold)
		dither_sensitivity_slider.value = config.get_value("material", "shadow_sensitivity", DEFAULT_VALUES.shadow_sensitivity)
		dither_dot_size_spin.value = config.get_value("material", "dot_size", DEFAULT_VALUES.dot_size)
		dither_dot_color.color = config.get_value("material", "dither_color", DEFAULT_VALUES.dither_color)
		
		# Load current color preset name
		current_color_preset_name = config.get_value("material", "current_color_preset", "Custom")
	else:
		# Load default values if no config file exists
		_load_default_values()

func _load_default_values():
	# Set default values from DEFAULT_VALUES constant
	target_pixel_count_spin.value = DEFAULT_VALUES.target_pixel_count
	color_steps_spin.value = DEFAULT_VALUES.color_steps
	edge_strength_slider.value = DEFAULT_VALUES.edge_strength
	sharpness_slider.value = DEFAULT_VALUES.sharpness
	hue_shift_slider.value = DEFAULT_VALUES.hue_shift
	saturation_slider.value = DEFAULT_VALUES.saturation
	value_slider.value = DEFAULT_VALUES.value
	contrast_slider.value = DEFAULT_VALUES.contrast
	gamma_slider.value = DEFAULT_VALUES.gamma
	brightness_slider.value = DEFAULT_VALUES.brightness
	outline_spin.value = DEFAULT_VALUES.outline
	outline_color_picker.color = DEFAULT_VALUES.outline_color
	post_process_outline.value = DEFAULT_VALUES.post_process_outline
	shadow_strength_slider.value = DEFAULT_VALUES.shadow_strength
	highlight_strength_slider.value = DEFAULT_VALUES.highlight_strength
	shadow_strength_color_picker.color = DEFAULT_VALUES.shadow_color
	highlight_strength_color_picker.color = DEFAULT_VALUES.highlight_color
	use_palette_check_box.button_pressed = DEFAULT_VALUES.use_palette
	
	# Set SLso8 palette colors
	use_palette_color_1.color = DEFAULT_VALUES.palette_color_1
	use_palette_color_2.color = DEFAULT_VALUES.palette_color_2
	use_palette_color_3.color = DEFAULT_VALUES.palette_color_3
	use_palette_color_4.color = DEFAULT_VALUES.palette_color_4
	use_palette_color_5.color = DEFAULT_VALUES.palette_color_5
	use_palette_color_6.color = DEFAULT_VALUES.palette_color_6
	use_palette_color_7.color = DEFAULT_VALUES.palette_color_7
	use_palette_color_8.color = DEFAULT_VALUES.palette_color_8
	
	# Set dithering defaults
	dither_amount_slider.value = DEFAULT_VALUES.dither_amount
	dither_blend_slider.value = DEFAULT_VALUES.dither_blend
	dither_threshold_slider.value = DEFAULT_VALUES.dither_threshold
	dither_sensitivity_slider.value = DEFAULT_VALUES.shadow_sensitivity
	dither_dot_size_spin.value = DEFAULT_VALUES.dot_size
	dither_dot_color.color = DEFAULT_VALUES.dither_color
	
	# Set default color preset
	current_color_preset_name = "Custom"

func _save_current_values():
	# Don't save while loading a preset or color preset
	if is_loading_preset or is_loading_color_preset:
		return
		
	var config = ConfigFile.new()
	
	# Save current values to config
	config.set_value("material", "target_pixel_count", int(target_pixel_count_spin.value))
	config.set_value("material", "color_steps", int(color_steps_spin.value))
	config.set_value("material", "edge_strength", edge_strength_slider.value)
	config.set_value("material", "sharpness", sharpness_slider.value)
	config.set_value("material", "hue_shift", hue_shift_slider.value)
	config.set_value("material", "saturation", saturation_slider.value)
	config.set_value("material", "value", value_slider.value)
	config.set_value("material", "contrast", contrast_slider.value)
	config.set_value("material", "gamma", gamma_slider.value)
	config.set_value("material", "brightness", brightness_slider.value)
	config.set_value("material", "outline", outline_spin.value)
	config.set_value("material", "outline_color", outline_color_picker.color)
	config.set_value("material", "post_process_outline", post_process_outline.value)
	config.set_value("material", "shadow_strength", shadow_strength_slider.value)
	config.set_value("material", "highlight_strength", highlight_strength_slider.value)
	config.set_value("material", "shadow_color", shadow_strength_color_picker.color)
	config.set_value("material", "highlight_color", highlight_strength_color_picker.color)
	config.set_value("material", "use_palette", use_palette_check_box.button_pressed)
	
	# Save palette colors
	config.set_value("material", "palette_color_1", use_palette_color_1.color)
	config.set_value("material", "palette_color_2", use_palette_color_2.color)
	config.set_value("material", "palette_color_3", use_palette_color_3.color)
	config.set_value("material", "palette_color_4", use_palette_color_4.color)
	config.set_value("material", "palette_color_5", use_palette_color_5.color)
	config.set_value("material", "palette_color_6", use_palette_color_6.color)
	config.set_value("material", "palette_color_7", use_palette_color_7.color)
	config.set_value("material", "palette_color_8", use_palette_color_8.color)
	
	# Save dithering parameters
	config.set_value("material", "dither_amount", dither_amount_slider.value)
	config.set_value("material", "dither_blend", dither_blend_slider.value)
	config.set_value("material", "dither_threshold", dither_threshold_slider.value)
	config.set_value("material", "shadow_sensitivity", dither_sensitivity_slider.value)
	config.set_value("material", "dot_size", dither_dot_size_spin.value)
	config.set_value("material", "dither_color", dither_dot_color.color)
	
	# Save current color preset name
	config.set_value("material", "current_color_preset", current_color_preset_name)
	
	# Save the config file
	config.save(CONFIG_FILE_PATH)

func _connect_signals():
	# Connect spinbox and slider signals
	target_pixel_count_spin.value_changed.connect(_on_target_pixel_count_changed)
	color_steps_spin.value_changed.connect(_on_color_steps_changed)
	edge_strength_slider.value_changed.connect(_on_edge_strength_changed)
	sharpness_slider.value_changed.connect(_on_sharpness_changed)
	hue_shift_slider.value_changed.connect(_on_hue_shift_changed)
	saturation_slider.value_changed.connect(_on_saturation_changed)
	value_slider.value_changed.connect(_on_value_changed)
	contrast_slider.value_changed.connect(_on_contrast_changed)
	gamma_slider.value_changed.connect(_on_gamma_changed)
	brightness_slider.value_changed.connect(_on_brightness_changed)
	outline_spin.value_changed.connect(_on_outline_changed)
	post_process_outline.value_changed.connect(_on_post_process_outline_changed)
	
	# Connect color picker signals
	outline_color_picker.color_changed.connect(_on_outline_color_changed)
	shadow_strength_color_picker.color_changed.connect(_on_shadow_color_changed)
	highlight_strength_color_picker.color_changed.connect(_on_highlight_color_changed)
	use_palette_color_1.color_changed.connect(_on_palette_color_1_changed)
	use_palette_color_2.color_changed.connect(_on_palette_color_2_changed)
	use_palette_color_3.color_changed.connect(_on_palette_color_3_changed)
	use_palette_color_4.color_changed.connect(_on_palette_color_4_changed)
	use_palette_color_5.color_changed.connect(_on_palette_color_5_changed)
	use_palette_color_6.color_changed.connect(_on_palette_color_6_changed)
	use_palette_color_7.color_changed.connect(_on_palette_color_7_changed)
	use_palette_color_8.color_changed.connect(_on_palette_color_8_changed)
	
	# Connect slider signals for PixelArt Stylizer
	shadow_strength_slider.value_changed.connect(_on_shadow_strength_changed)
	highlight_strength_slider.value_changed.connect(_on_highlight_strength_changed)
	
	# Connect dithering signals
	dither_amount_slider.value_changed.connect(_on_dither_amount_changed)
	dither_blend_slider.value_changed.connect(_on_dither_blend_changed)
	dither_threshold_slider.value_changed.connect(_on_dither_threshold_changed)
	dither_sensitivity_slider.value_changed.connect(_on_dither_sensitivity_changed)
	dither_dot_size_spin.value_changed.connect(_on_dither_dot_size_changed)
	dither_dot_color.color_changed.connect(_on_dither_dot_color_changed)
	
	# Connect checkbox signal
	use_palette_check_box.toggled.connect(_on_use_palette_toggled)
	
	# Connect reset button
	reset_material_button.pressed.connect(_on_reset_material_pressed)
	
	# Connect preset UI signals
	preset_option_button.item_selected.connect(_on_preset_selected)
	search_text_line_edit.text_changed.connect(_on_search_text_changed)
	save_preset_button.pressed.connect(_on_save_preset_pressed)
	delete_preset_button.pressed.connect(_on_delete_preset_pressed)
	
	# Connect color preset UI signals
	color_preset_option_button.item_selected.connect(_on_color_preset_selected)
	
	# Connect sample colors button
	sample_colors_button.pressed.connect(_on_sample_colors_pressed)

func _apply_all_values():
	# Apply all current values to the shader
	PIXEL_MATERIAL.set_shader_parameter("target_pixel_count", int(target_pixel_count_spin.value))
	PIXEL_MATERIAL.set_shader_parameter("color_steps", int(color_steps_spin.value))
	PIXEL_MATERIAL.set_shader_parameter("edge_strength", edge_strength_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("sharpness", sharpness_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("hue_shift", hue_shift_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("saturation", saturation_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("value_brightness", value_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("contrast", contrast_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("gamma", gamma_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("brightness", brightness_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("outline_thickness", outline_spin.value)
	PIXEL_MATERIAL.set_shader_parameter("outline_color", outline_color_picker.color)
	PIXEL_MATERIAL.set_shader_parameter("use_palette", use_palette_check_box.button_pressed)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_1", use_palette_color_1.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_2", use_palette_color_2.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_3", use_palette_color_3.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_4", use_palette_color_4.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_5", use_palette_color_5.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_6", use_palette_color_6.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_7", use_palette_color_7.color)
	PIXEL_MATERIAL.set_shader_parameter("palette_color_8", use_palette_color_8.color)
	
	# Apply dithering parameters
	PIXEL_MATERIAL.set_shader_parameter("dither_amount", dither_amount_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("dither_blend", dither_blend_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("dither_threshold", dither_threshold_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("shadow_sensitivity", dither_sensitivity_slider.value)
	PIXEL_MATERIAL.set_shader_parameter("dot_size", dither_dot_size_spin.value)
	PIXEL_MATERIAL.set_shader_parameter("dither_color", dither_dot_color.color)
	
	# Apply PixelArt Stylizer parameters
	PIXELART_STYLIZER.set_shader_parameter("outline_size", post_process_outline.value)
	PIXELART_STYLIZER.set_shader_parameter("shadow_strength", shadow_strength_slider.value)
	PIXELART_STYLIZER.set_shader_parameter("highlight_strength", highlight_strength_slider.value)
	PIXELART_STYLIZER.set_shader_parameter("shadow_color", shadow_strength_color_picker.color)
	PIXELART_STYLIZER.set_shader_parameter("highlight_color", highlight_strength_color_picker.color)

# Preset signal handlers
func _on_preset_selected(index: int):
	if index >= 0 and index < filtered_presets.size():
		var preset_name = filtered_presets[index]
		_select_preset(preset_name)

func _on_search_text_changed(_new_text: String):
	_update_preset_list()

func _on_save_preset_pressed():
	var preset_name = search_text_line_edit.text.strip_edges()
	
	# If no name provided, generate one
	if preset_name.is_empty():
		preset_name = _generate_preset_name()
		search_text_line_edit.text = preset_name
	
	# Check if it's a built-in preset
	if BUILTIN_PRESETS.has(preset_name):
		_update_console("Cannot overwrite built-in preset: " + preset_name)
		return
	
	# Save the preset
	_save_current_as_preset(preset_name)

func _on_delete_preset_pressed():
	var selected_index = preset_option_button.selected
	if selected_index >= 0 and selected_index < filtered_presets.size():
		var preset_name = filtered_presets[selected_index]
		_delete_preset(preset_name)

# Color preset signal handlers
func _on_color_preset_selected(index: int):
	if index >= 0 and index < filtered_color_presets.size():
		var preset_name = filtered_color_presets[index]
		_select_color_preset(preset_name)

# Sample colors button signal handler
func _on_sample_colors_pressed():
	sample_colors_from_render()

# Signal handlers
func _on_target_pixel_count_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("target_pixel_count", int(value))
	_save_current_values()

func _on_color_steps_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("color_steps", int(value))
	_save_current_values()

func _on_edge_strength_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("edge_strength", value)
	_save_current_values()

func _on_sharpness_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("sharpness", value)
	_save_current_values()

func _on_hue_shift_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("hue_shift", value)
	_save_current_values()

func _on_saturation_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("saturation", value)
	_save_current_values()

func _on_value_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("value_brightness", value)
	_save_current_values()

func _on_contrast_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("contrast", value)
	_save_current_values()

func _on_gamma_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("gamma", value)
	_save_current_values()

func _on_brightness_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("brightness", value)
	_save_current_values()

func _on_outline_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("outline_thickness", value)
	_save_current_values()

func _on_outline_color_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("outline_color", color)
	_save_current_values()

func _on_use_palette_toggled(pressed: bool):
	PIXEL_MATERIAL.set_shader_parameter("use_palette", pressed)
	_save_current_values()

func _on_palette_color_1_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_1", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			# Update and save custom colors when already on Custom
			all_color_presets["Custom"]["palette_color_1"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_2_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_2", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_2"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_3_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_3", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_3"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_4_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_4", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_4"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_5_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_5", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_5"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_6_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_6", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_6"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_7_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_7", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_7"] = color
			_save_custom_colors()
	_save_current_values()

func _on_palette_color_8_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("palette_color_8", color)
	if not is_loading_color_preset:
		if current_color_preset_name != "Custom":
			_switch_to_custom_preset()
		else:
			all_color_presets["Custom"]["palette_color_8"] = color
			_save_custom_colors()
	_save_current_values()

# Dithering signal handlers
func _on_dither_amount_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("dither_amount", value)
	_save_current_values()

func _on_dither_blend_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("dither_blend", value)
	_save_current_values()

func _on_dither_threshold_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("dither_threshold", value)
	_save_current_values()

func _on_dither_sensitivity_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("shadow_sensitivity", value)
	_save_current_values()

func _on_dither_dot_size_changed(value: float):
	PIXEL_MATERIAL.set_shader_parameter("dot_size", value)
	_save_current_values()

func _on_dither_dot_color_changed(color: Color):
	PIXEL_MATERIAL.set_shader_parameter("dither_color", color)
	_save_current_values()

# PixelArt Stylizer signal handlers
func _on_post_process_outline_changed(value: float):
	PIXELART_STYLIZER.set_shader_parameter("outline_size", value)
	_save_current_values()

func _on_shadow_strength_changed(value: float):
	PIXELART_STYLIZER.set_shader_parameter("shadow_strength", value)
	_save_current_values()

func _on_highlight_strength_changed(value: float):
	PIXELART_STYLIZER.set_shader_parameter("highlight_strength", value)
	_save_current_values()

func _on_shadow_color_changed(color: Color):
	PIXELART_STYLIZER.set_shader_parameter("shadow_color", color)
	_save_current_values()

func _on_highlight_color_changed(color: Color):
	PIXELART_STYLIZER.set_shader_parameter("highlight_color", color)
	_save_current_values()

# Reset button handler
func _on_reset_material_pressed():
	_load_default_values()
	_apply_all_values()
	_save_current_values()  # Save the default values to config
	_update_console("Material parameters reset to default values")

# Utility functions
func reset_to_defaults():
	_load_default_values()
	_apply_all_values()
	_save_current_values()

func load_slso8_palette():
	for i in range(8):
		var color_picker = get("use_palette_color_" + str(i + 1))
		if color_picker:
			color_picker.color = SLSO8_COLORS[i]
	_apply_all_values()
	_save_current_values()

# Public API functions for external access
func get_current_preset_name() -> String:
	return current_preset_name

func get_all_preset_names() -> Array[String]:
	var names: Array[String] = []
	for preset_name in all_presets.keys():
		names.append(preset_name)
	return names

func load_preset_by_name(preset_name: String) -> bool:
	if all_presets.has(preset_name):
		_select_preset(preset_name)
		return true
	return false

# Public API functions for color presets
func get_current_color_preset_name() -> String:
	return current_color_preset_name

func get_all_color_preset_names() -> Array[String]:
	var names: Array[String] = []
	for preset_name in all_color_presets.keys():
		names.append(preset_name)
	return names

func load_color_preset_by_name(preset_name: String) -> bool:
	if all_color_presets.has(preset_name):
		_select_color_preset(preset_name)
		return true
	return false

# Sample colors from the rendered image and apply them as custom palette
func sample_colors_from_render():
	"""
	Samples 8 dominant colors from the current rendered image and applies them as custom colors
	"""
	if not pixel_renderer:
		_update_console("ERROR: No reference to PixelRenderer found")
		return
	
	# Get the current rendered image from the SubViewport
	if not sub_viewport:
		_update_console("ERROR: SubViewport not found in PixelRenderer")
		return
	
	var viewport_texture = sub_viewport.get_texture()
	if not viewport_texture:
		_update_console("ERROR: Could not get texture from SubViewport")
		return
	
	var image = viewport_texture.get_image()
	if not image:
		_update_console("ERROR: Could not get image from SubViewport texture")
		return
	
	_update_console("Sampling colors from rendered image (" + str(image.get_width()) + "x" + str(image.get_height()) + ")")
	
	# Sample colors from the image
	var sampled_colors = _sample_dominant_colors(image, 8)
	
	if sampled_colors.size() < 8:
		_update_console("WARNING: Only found " + str(sampled_colors.size()) + " colors, filling remaining with defaults")
		# Fill remaining colors with defaults if needed
		while sampled_colors.size() < 8:
			sampled_colors.append(SLSO8_COLORS[sampled_colors.size() % SLSO8_COLORS.size()])
	
	# Apply the sampled colors to the palette
	_apply_sampled_colors_to_palette(sampled_colors)
	
	_update_console("Successfully applied sampled colors to custom palette")

func _sample_dominant_colors(image: Image, num_colors: int) -> Array[Color]:
	"""
	Sample dominant colors from an image using a simple color quantization approach
	"""
	var color_counts: Dictionary = {}
	var total_pixels: int = 0
	
	# Sample every nth pixel to improve performance (adjust step for quality vs speed)
	var step = max(1, int(sqrt(image.get_width() * image.get_height()) / 100))
	
	# Count color occurrences (with some color grouping to avoid too many similar colors)
	for y in range(0, image.get_height(), step):
		for x in range(0, image.get_width(), step):
			var pixel_color = image.get_pixel(x, y)
			
			# Skip transparent pixels
			if pixel_color.a < 0.1:
				continue
			
			# Group similar colors together (reduce precision to group similar colors)
			var grouped_color = Color(
				round(pixel_color.r * 16) / 16.0,
				round(pixel_color.g * 16) / 16.0,
				round(pixel_color.b * 16) / 16.0,
				1.0
			)
			
			var color_key = str(grouped_color)
			if color_counts.has(color_key):
				color_counts[color_key].count += 1
			else:
				color_counts[color_key] = {"color": grouped_color, "count": 1}
			
			total_pixels += 1
	
	if total_pixels == 0:
		_update_console("WARNING: No valid pixels found in image")
		return []
	
	# Sort colors by frequency
	var color_array: Array = []
	for color_data in color_counts.values():
		color_array.append(color_data)
	
	color_array.sort_custom(func(a, b): return a.count > b.count)
	
	# Extract the most frequent colors
	var dominant_colors: Array[Color] = []
	var max_colors = min(num_colors, color_array.size())
	
	for i in range(max_colors):
		dominant_colors.append(color_array[i].color)
	
	_update_console("Found " + str(dominant_colors.size()) + " dominant colors from " + str(total_pixels) + " sampled pixels")
	return dominant_colors

func _apply_sampled_colors_to_palette(colors: Array[Color]):
	"""
	Apply the sampled colors to the palette color pickers and update the custom preset
	"""
	is_loading_color_preset = true
	
	# Apply colors to the palette color pickers
	for i in range(min(8, colors.size())):
		var color_picker = get("use_palette_color_" + str(i + 1))
		if color_picker:
			color_picker.color = colors[i]
	
	# Enable palette mode
	use_palette_check_box.button_pressed = true
	
	# Switch to Custom preset and save the colors
	_switch_to_custom_preset()
	
	# Apply changes to shader
	_apply_all_values()
	
	is_loading_color_preset = false
	
	_update_console("Applied sampled colors to custom palette")
