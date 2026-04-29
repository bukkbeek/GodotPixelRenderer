extends Node3D

signal single_export_finished

@onready var export_dir_path: Label = %ExportDirPath
@onready var select_folder_button: Button = %SelectFolderButton
@onready var export_button: Button = %ExportButton

@onready var file_dialog: FileDialog = %FileDialog
@onready var texture_rect: TextureRect = %PixelCanvas

@onready var fps_spin_box: SpinBox = %FpsSpin
@onready var ignore_fps: CheckBox = %IgnoreAnimation

@onready var left_renderer: Control = %LeftRenderer
@onready var renderer: PanelContainer = %Renderer
@onready var right_renderer: Control = %RightRenderer
@onready var renderer_container: BoxContainer = %RendererContainer
@onready var models_spawner: Node3D = %ModelsSpawner

@onready var prefix_text: LineEdit = %PrefixText

@onready var sub_viewport: SubViewport = $SubViewport

@onready var bg_color_rect: ColorRect = %BgColorRect
@onready var bg_color_check_box: CheckButton = %BgColorCheckBox
@onready var bg_color_picker: ColorPickerButton = %BgColorPicker
@onready var progress_bar: ProgressBar = %ProgressBar

@onready var console: HBoxContainer = %ConsoleContainer
@onready var viewport_background: ColorRect = %ViewportBackgroundColorRect



@export var start_frame: int = 0
@export var end_frame: int = 30
@export var fps: int = 12



@onready var resolution_x: SpinBox = %ResolutionX
@onready var resolution_y: SpinBox = %ResolutionY
@onready var preview_image_check_box: CheckButton = %PreviewImageCheckBox
@onready var view_mode_dropdown : OptionButton = %ViewModeDropDown
@onready var canvas_size_label: Label = %CanvasSizeLabel
@onready var pixel_material_script: Node = $PixelMaterial




var export_directory: String = ""
var is_exporting: bool = false
var current_export_frame: int = 0
var total_frames: int = 0

# Timer for canvas updates
var canvas_update_timer: Timer

# Cached texture for FPS-controlled display
var cached_texture: ImageTexture

# Base canvas size - always 800x800
var BASE_CANVAS_SIZE: Vector2 = Vector2(800, 800)

# Animation export variables
var animation_player: AnimationPlayer = null
var was_playing_before_export: bool = false
var original_animation_position: float = 0.0
var export_frame_list: Array = []
var export_frame_index: int = 0

var capture_viewport: SubViewport = null
var renderer_clone: Node = null



func _ready():
	# Initialize console
	console._update("EffectBlocks PixelRenderer")
	console._update("Visit https://bukkbeek.itch.io/effectblocks")
	console._update("PixelRenderer initialized successfully")
	console._update("Canvas update timer set to " + str(fps) + " FPS")
	console._update("Base canvas size: " + str(BASE_CANVAS_SIZE) + "x" + str(BASE_CANVAS_SIZE))
	console._update("Default minion skeleton by KayKit: kaylousberg.itch.io/kaykit-skeletons")
	
	texture_rect.texture = sub_viewport.get_texture()
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE

	# Keep SubViewport updating continuously so models run at normal speed
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	
	# Initialize cached texture
	cached_texture = ImageTexture.new()
	
	# Create and configure the canvas update timer for visual feed updates
	canvas_update_timer = Timer.new()
	canvas_update_timer.wait_time = 1.0 / fps
	canvas_update_timer.timeout.connect(_on_canvas_timer_timeout)
	add_child(canvas_update_timer)
	canvas_update_timer.start()
	
	# Connect signals
	export_button.pressed.connect(_on_export_button_pressed)
	select_folder_button.pressed.connect(_on_select_folder_button_pressed)
	fps_spin_box.value_changed.connect(_on_fps_changed)
	resolution_x.value_changed.connect(_on_resolution_changed)
	resolution_y.value_changed.connect(_on_resolution_changed)
	file_dialog.dir_selected.connect(_on_directory_selected)
	bg_color_check_box.toggled.connect(_on_bg_color_toggled)
	bg_color_picker.color_changed.connect(_on_bg_color_changed)
	
	# Setup View Modes
	_setup_view_mode_dropdown()
	view_mode_dropdown.item_selected.connect(_view_mode_item_selected)
	
	# Connect to ViewMaterials signal for automatic color remap toggle
	get_node("ViewMaterials").technical_mode_selected.connect(_on_technical_mode_selected)
	
	# Set up file dialog
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	
	# Initialize FPS spin box
	fps_spin_box.value = fps
	fps_spin_box.min_value = 1
	fps_spin_box.max_value = 120
	fps_spin_box.step = 1
	
	# Initialize resolution spin box
	resolution_x.value = 512
	resolution_x.min_value = 1
	resolution_x.step = 1
	
	resolution_y.value = 512
	resolution_y.min_value = 1
	resolution_y.step = 1
	
	# Initialize background color controls
	_update_bg_color_visibility()
	
	# Initialize export directory label
	_update_export_path_label()
	
	# Initialize canvas size label
	_update_canvas_size_label()
	
	# Initialize progress bar
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	

func _on_fps_changed(value: float):
	fps = int(value)
	if fps > 0:
		canvas_update_timer.wait_time = 1.0 / fps
		canvas_update_timer.start()
	else:
		canvas_update_timer.stop()
	console._update("Preview FPS changed to " + str(fps))

func _on_canvas_timer_timeout():
	# Вместо копирования данных, мы просто просим вьюпорт
	# отрендерить один новый кадр.
	# TextureRect, который уже смотрит на него, обновится автоматически.
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	
func _on_resolution_changed(value: float):
	var res_x = resolution_x.value
	var res_y = resolution_y.value
	if res_x > res_y:
		BASE_CANVAS_SIZE = Vector2(800, 800*(float(res_y) / float(res_x)))
	else:
		BASE_CANVAS_SIZE = Vector2(800*(float(res_x) / float(res_y)), 800)
		
	print_debug(BASE_CANVAS_SIZE)
	print_debug(res_x)
	print_debug(res_y)
	if BASE_CANVAS_SIZE.x > BASE_CANVAS_SIZE.y:
		renderer_container.vertical = true
		texture_rect.custom_minimum_size = BASE_CANVAS_SIZE
		var offset_y = (800-BASE_CANVAS_SIZE.y)/2
		left_renderer.custom_minimum_size = Vector2(800, int(offset_y))
		right_renderer.custom_minimum_size = Vector2(800, int(offset_y))
		viewport_background.position =Vector2(555, int(offset_y))
	else:
		renderer_container.vertical = false
		texture_rect.custom_minimum_size = BASE_CANVAS_SIZE
		var offset_x = (800-BASE_CANVAS_SIZE.x)/2
		
		left_renderer.custom_minimum_size = Vector2(int(offset_x), 800 )
		right_renderer.custom_minimum_size = Vector2(int(offset_x), 800)
		viewport_background.position =Vector2(555+int(offset_x), 0)
	print_debug(texture_rect.custom_minimum_size)
	sub_viewport.size = BASE_CANVAS_SIZE
	viewport_background.custom_minimum_size = BASE_CANVAS_SIZE
	viewport_background.size = BASE_CANVAS_SIZE
	_update_canvas_size_label()
	console._update("Export resolution changed to " + str(int(res_x)) + "x" + str(int(res_y)))

func start_export() -> void:
	_on_export_button_pressed()

func _on_export_button_pressed():
	if is_exporting:
		return
	
	if export_directory == "":
		console._update("No export directory selected, opening folder dialog...")
		_on_select_folder_button_pressed()
		return
		
	# Start the export process
	_start_export()

func _on_select_folder_button_pressed():
	# Open file dialog to select export directory
	file_dialog.popup_centered(Vector2i(800, 600))

func _on_directory_selected(dir: String):
	export_directory = dir
	console._update("Export directory set to: " + export_directory)
	# Update the label to show the selected path
	_update_export_path_label()

func _find_animation_player(node: Node) -> AnimationPlayer:
	# Check if current node is an AnimationPlayer
	if node is AnimationPlayer:
		return node as AnimationPlayer
	
	# Recursively search children
	for child in node.get_children():
		var result = _find_animation_player(child)
		if result != null:
			return result
	
	return null

func _start_export():
	if export_directory == "":
		console._update("No export directory selected")
		return
	
	if console.console_container_expanded:
		console._on_expand_log_button_pressed()
	# Get frame range from models_spawner UI instead of hardcoded values
	var actual_start_frame = start_frame
	var actual_end_frame = end_frame
	
	if models_spawner:
		# Try to get the frame values from models_spawner directly (it has start_spin and end_spin as @onready vars)
		if models_spawner.has_method("get") and models_spawner.get("start_spin") != null and models_spawner.get("end_spin") != null:
			actual_start_frame = int(models_spawner.start_spin.value)
			actual_end_frame = int(models_spawner.end_spin.value)
			console._update("Using frame range from UI: " + str(actual_start_frame) + " to " + str(actual_end_frame))
		else:
			console._update("Could not access frame range UI controls, using default values")
	
	if actual_start_frame >= actual_end_frame:
		console._update("Invalid frame range: start_frame must be less than end_frame")
		return
	
	# Calculate frame skip based on FPS (baseline 30 FPS)
	var frame_skip = int(30.0 / float(fps))
	if frame_skip < 1:
		frame_skip = 1
	
	console._update("Export FPS: " + str(fps) + " (will render every " + str(frame_skip) + " frame(s) from 30 FPS baseline)")
	
	# Find the animation player in the loaded model
	if models_spawner:
		var loaded_model = models_spawner.get_loaded_model()
		if loaded_model:
			animation_player = _find_animation_player(loaded_model)
			if animation_player and not ignore_fps.button_pressed:
				console._update("Found AnimationPlayer - animation will play during export")
				# Store current state
				was_playing_before_export = animation_player.is_playing()
				original_animation_position = animation_player.current_animation_position
				
				# Ensure animation is playing
				if not animation_player.is_playing():
					animation_player.play()
					console._update("Started animation playback for export")
				animation_player.speed_scale = 0.0
			else:
				console._update("No AnimationPlayer found - exporting static frames (or ignoring export pressed)")
		else:
			console._update("No model loaded - exporting static frames")
	
	is_exporting = true
	current_export_frame = actual_start_frame
	start_frame = actual_start_frame  # Update the instance variables
	end_frame = actual_end_frame
	
	# Calculate total frames that will actually be exported (considering frame skipping)
	var frames_to_export = []
	if ignore_fps.button_pressed:
		frames_to_export.append(0)
	else:
		for frame_num in range(start_frame, end_frame + 1):
			if (frame_num - start_frame) % frame_skip == 0:
				frames_to_export.append(frame_num)
	
	total_frames = frames_to_export.size()
	
	export_button.text = "Exporting..."
	export_button.disabled = true
	
	# Initialize progress bar
	progress_bar.value = 0
	
	console._update("Starting export from frame " + str(start_frame) + " to " + str(end_frame))
	console._update("Total frames to export: " + str(total_frames) + " at " + str(fps) + " FPS (skipping " + str(frame_skip - 1) + " frames between renders)")
	console._update("Frames to render: " + str(frames_to_export))
	
	# Store the frames list and start with the first frame
	export_frame_list = frames_to_export
	export_frame_index = 0
	
	# Start the export process
	_export_next_frame()

func _export_next_frame():
	
	if export_frame_index >= export_frame_list.size():
		_finish_export()
		return
	
	# Get the actual frame number to render
	var frame_to_render = export_frame_list[export_frame_index]
	
	# Update progress bar
	var progress_percent = float(export_frame_index) / float(total_frames) * 100.0
	progress_bar.value = progress_percent
	
	console._update("Processing frame " + str(frame_to_render) + " (" + str(export_frame_index + 1) + "/" + str(total_frames) + ")")
	
	# If we have an animation player, seek to the correct frame position
	if animation_player and animation_player.current_animation != "" and not ignore_fps.button_pressed:
		# Animation timing always uses 30 FPS baseline
		var target_time = float(frame_to_render) / 30.0
		
		# Make sure we don't exceed animation length
		var animation_length = animation_player.current_animation_length
		if target_time > animation_length:
			target_time = animation_length
		
		# Seek to the exact frame position
		animation_player.seek(target_time, true)
		console._update("Animation seeked to time: " + str(target_time) + "s (frame " + str(frame_to_render) + " at 30 FPS baseline)")
	
	# Wait for multiple frames to ensure proper rendering and animation update
	#var s = renderer_container.size
	#print_debug(s)
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Capture the entire Renderer control node and its contents
	var image = await _capture_control_node()
	
	if image:
		var res_x = resolution_x.value
		var res_y = resolution_y.value
		
		
		# Apply resolution scaling if not in preview mode
		if not preview_image_check_box.button_pressed:
			var target_size_x = int(res_x)
			var target_size_y = int(res_y)
			if image.get_width() != target_size_x or image.get_height() != target_size_y:
				console._update("Scaling image to " + str(target_size_x) + "x" + str(target_size_y))
				image.resize(target_size_x, target_size_y, Image.INTERPOLATE_NEAREST)
			#image = _scale_image_nearest_neighbor(image, int(resolution.value))
		
		# Get prefix from UI, default to "frame" if empty
		var prefix = prefix_text.text.strip_edges()
		if prefix.is_empty():
			prefix = "frame"
		
		# Use actual frame numbers for exported files (Blender style)
		var filename = "%s_%04d.png" % [prefix, frame_to_render]
		var filepath = export_directory.path_join(filename)
		
		console._update("Saving frame to: " + filepath)
		
		# Save the image
		var error = image.save_png(filepath)
		if error != OK:
			console._update("ERROR: Failed to save frame " + str(frame_to_render) + " - Error code: " + str(error))
		else:
			var size_info = ""
			if preview_image_check_box.button_pressed:
				size_info = " (preview size: " + str(image.get_width()) + "x" + str(image.get_height()) + ")"
			else:
				size_info = " (scaled to: " + str(image.get_width()) + "x" + str(image.get_height()) + ")"
			console._update("✓ Exported frame " + str(frame_to_render) + " as " + filename + " (" + str(export_frame_index + 1) + "/" + str(total_frames) + ")" + size_info)
	else:
		console._update("ERROR: Failed to capture frame " + str(frame_to_render))
	
	export_frame_index += 1
	
	# Continue with next frame
	_export_next_frame()

func _capture_control_node() -> Image:
	if not renderer:
		console._update("ERROR: Renderer control node is null")
		return null
	
	# Get the size of the control node
	var size = renderer.size
	if size.x <= 0 or size.y <= 0:
		console._update("ERROR: Renderer control node has invalid size: " + str(size))
		return null
	
	console._update("Capturing frame at size: " + str(size))
	
	# CRITICAL: Force main SubViewport to render a fresh frame before cloning
	# This ensures the TextureRect has the latest image
	var original_update_mode = sub_viewport.render_target_update_mode
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	await get_tree().process_frame
	
	# Create a SubViewport to render the control
	capture_viewport = SubViewport.new()
	capture_viewport.size = Vector2i(size)
	capture_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	
	# Enable transparency in the SubViewport
	capture_viewport.transparent_bg = true
	if not is_instance_valid(capture_viewport):
		sub_viewport.render_target_update_mode = original_update_mode
		return null
		
	# Temporarily add the SubViewport to the scene
	add_child(capture_viewport)
	
	# Clone the renderer node and its children
	renderer_clone = renderer.duplicate(DUPLICATE_USE_INSTANTIATION)
	capture_viewport.add_child(renderer_clone)
	
	# Restore main viewport update mode
	sub_viewport.render_target_update_mode = original_update_mode
	
	# Force the capture viewport to render
	capture_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	await get_tree().process_frame
	await get_tree().process_frame  # Wait an extra frame for safety
	
	# Get the rendered image with proper alpha channel
	var viewport_texture = capture_viewport.get_texture()
	if not viewport_texture:
		console._update("ERROR: Could not get texture from SubViewport")
		# Clean up before returning
		capture_viewport.remove_child(renderer_clone)
		renderer_clone.queue_free()
		remove_child(capture_viewport)
		capture_viewport.queue_free()
		capture_viewport = null
		renderer_clone = null
		return null
	
	var image = viewport_texture.get_image()
	
	# Clean up
	capture_viewport.remove_child(renderer_clone)
	renderer_clone.queue_free()
	remove_child(capture_viewport)
	capture_viewport.queue_free()
	capture_viewport = null
	renderer_clone = null
	
	
	if not image:
		console._update("ERROR: Could not capture image from SubViewport")
		return null
	
	# Ensure the image has an alpha channel for transparency
	if image.get_format() != Image.FORMAT_RGBA8:
		image.convert(Image.FORMAT_RGBA8)
		console._update("Image converted to RGBA8 format")
	
	console._update("Frame captured successfully")
	# The image should now preserve the alpha channel from the SubViewport
	return image

func _scale_image_nearest_neighbor(source_image: Image, target_size: int) -> Image:
	"""
	Scale an image to target_size x target_size using nearest neighbor filtering
	to preserve pixel art aesthetics
	"""
	if not source_image:
		console._update("ERROR: Source image is null for scaling")
		return null
	
	var source_width = source_image.get_width()
	var source_height = source_image.get_height()
	
	# If already the target size, return as-is
	if source_width == target_size and source_height == target_size:
		console._update("Image already at target size (" + str(target_size) + "x" + str(target_size) + ")")
		return source_image
	
	console._update("Scaling image from " + str(source_width) + "x" + str(source_height) + " to " + str(target_size) + "x" + str(target_size))
	
	# Create a new image with the target size
	var scaled_image = Image.create(target_size, target_size, false, Image.FORMAT_RGBA8)
	
	# Calculate scaling factors
	var scale_x = float(source_width) / float(target_size)
	var scale_y = float(source_height) / float(target_size)
	
	# Apply nearest neighbor scaling
	for y in range(target_size):
		for x in range(target_size):
			# Find the nearest source pixel
			var source_x = int(x * scale_x)
			var source_y = int(y * scale_y)
			
			# Clamp to source image bounds
			source_x = clamp(source_x, 0, source_width - 1)
			source_y = clamp(source_y, 0, source_height - 1)
			
			# Get the pixel from source and set it in the scaled image
			var pixel_color = source_image.get_pixel(source_x, source_y)
			scaled_image.set_pixel(x, y, pixel_color)
	
	console._update("Image scaling completed")
	return scaled_image

func _finish_export():
	is_exporting = false
	export_button.text = "Export"
	export_button.disabled = false
	
	# Restore animation player state
	if animation_player:
		if was_playing_before_export:
			# Restore to original position and continue playing
			animation_player.seek(original_animation_position)
			if not animation_player.is_playing():
				animation_player.play()
			animation_player.speed_scale = 1.0
			console._update("Animation restored to original state")
		else:
			# Stop animation if it wasn't playing before
			animation_player.speed_scale = 1.0
			animation_player.stop()
			animation_player.seek(original_animation_position)
			console._update("Animation stopped and restored to original position")
	
	# Complete the progress bar
	progress_bar.value = 100
	
	console._update("------------------------------")
	console._update("EXPORT COMPLETED!")
	console._update("Total frames exported: " + str(total_frames))
	console._update("Export location: " + export_directory)
	console._update("Frame rate: " + str(fps) + " FPS")
	if animation_player:
		console._update("Animation was synchronized during export")
	console._update("------------------------------")
	
	# Optional: Show a completion message
	_show_completion_message(total_frames)

func _show_completion_message(frame_count: int):
	# You can implement a popup or notification here
	console._update("Animation export finished: " + str(frame_count) + " frames at " + str(fps) + " FPS")
	console._update("You can now create animations or GIFs from the exported frames")
	single_export_finished.emit()
	# Example: OS.shell_open(export_directory) # Opens the export folder


		
# Optional: Method to set frame range programmatically
func set_frame_range(start: int, end: int):
	start_frame = start
	end_frame = end
	console._update("Frame range set to: " + str(start) + " - " + str(end) + " (total: " + str(end - start + 1) + " frames)")

func _update_canvas():
	# Capture the current frame from the SubViewport
	var viewport_texture = sub_viewport.get_texture()
	if viewport_texture:
		var image = viewport_texture.get_image()
		if image:
			# Update the cached texture with the current frame
			cached_texture.set_image(image)
			# Apply the cached texture to the display
			texture_rect.texture = cached_texture
		else:
			console._update("WARNING: Could not get image from SubViewport for canvas update")
	else:
		console._update("WARNING: Could not get texture from SubViewport for canvas update")

func _update_export_path_label():
	if export_directory == "":
		export_dir_path.text = "No directory selected"
	else:
		export_dir_path.text = export_directory

func _update_canvas_size_label():
	#var export_resolution_x = float(resolution_x.value)
	#var export_resolution_y = float(resolution_y.value)
	#var base_size_x = float(BASE_CANVAS_SIZE.x)
	#var base_size_y = float(BASE_CANVAS_SIZE.y)
	#var scale_factor_x = export_resolution_x / base_size_x
	#var scale_factor_y = export_resolution_y / base_size_y
	#var scale_factor = Vector2(scale_factor_x, scale_factor_y)
	
	#var scale_text = " | *" + str(scale_factor) + " upscaled"
	
	canvas_size_label.text = "Canvas " + str(BASE_CANVAS_SIZE) + "px | Export Res. " + str(resolution_x.value) + "px :"+ str(resolution_y.value) + "px" 

func _on_bg_color_toggled(button_pressed: bool):
	_update_bg_color_visibility()
	if button_pressed:
		console._update("Background color enabled")
	else:
		console._update("Background color disabled")

func _on_bg_color_changed(color: Color):
	bg_color_rect.color = color
	console._update("Background color changed to: " + str(color))

func _update_bg_color_visibility():
	var should_be_visible = bg_color_check_box.button_pressed
	bg_color_rect.visible = should_be_visible


func _view_mode_item_selected(index : int):
	get_node("ViewMaterials").item_selected(index)
	var selection : String = view_mode_dropdown.get_item_text(index)
	console._update("Switching View Mode To " + selection)

func _on_technical_mode_selected(mode_name: String):
	# Automatically turn off color remap when technical modes are selected
	_turn_off_color_remap_if_enabled()
	console._update("Technical mode '" + mode_name + "' selected - color remap automatically disabled")

func _turn_off_color_remap_if_enabled():
	# Check if color remap is currently enabled and turn it off
	if pixel_material_script and pixel_material_script.use_palette_check_box.button_pressed:
		pixel_material_script.use_palette_check_box.button_pressed = false
		# Trigger the toggled signal to update the shader parameter
		pixel_material_script._on_use_palette_toggled(false)
		console._update("Color remap automatically turned off for technical view mode")

func _setup_view_mode_dropdown():
	view_mode_dropdown.clear()
	
	view_mode_dropdown.add_item("Albedo")
	view_mode_dropdown.add_item("Normal")
	view_mode_dropdown.add_item("Specular")
