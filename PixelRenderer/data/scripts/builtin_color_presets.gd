class_name BuiltinColorPresets
extends RefCounted

# Built-in color palette presets from popular Lospec palettes
# Each preset contains only the 8 palette colors, formatted for the pixel material system
static var COLOR_PRESETS = {
	"Custom": {
		"palette_color_1": Color(0.051, 0.169, 0.271, 1.0),  # Default SLSO8 colors as fallback
		"palette_color_2": Color(0.125, 0.235, 0.337, 1.0),
		"palette_color_3": Color(0.329, 0.306, 0.408, 1.0),
		"palette_color_4": Color(0.553, 0.412, 0.478, 1.0),
		"palette_color_5": Color(0.816, 0.506, 0.349, 1.0),
		"palette_color_6": Color(1.0, 0.667, 0.369, 1.0),
		"palette_color_7": Color(1.0, 0.831, 0.639, 1.0),
		"palette_color_8": Color(1.0, 0.925, 0.839, 1.0),
	},
	"SLSO8": {
		"palette_color_1": Color(0.051, 0.169, 0.271, 1.0),  # #0d2b45
		"palette_color_2": Color(0.125, 0.235, 0.337, 1.0),  # #203c56
		"palette_color_3": Color(0.329, 0.306, 0.408, 1.0),  # #544e68
		"palette_color_4": Color(0.553, 0.412, 0.478, 1.0),  # #8d697a
		"palette_color_5": Color(0.816, 0.506, 0.349, 1.0),  # #d08159
		"palette_color_6": Color(1.0, 0.667, 0.369, 1.0),    # #ffaa5e
		"palette_color_7": Color(1.0, 0.831, 0.639, 1.0),    # #ffd4a3
		"palette_color_8": Color(1.0, 0.925, 0.839, 1.0),    # #ffecd6
	},
	"Nyx8": {
		"palette_color_1": Color(0.031, 0.078, 0.118, 1.0),  # #08141e
		"palette_color_2": Color(0.059, 0.165, 0.247, 1.0),  # #0f2a3f
		"palette_color_3": Color(0.125, 0.224, 0.310, 1.0),  # #20394f
		"palette_color_4": Color(0.965, 0.839, 0.741, 1.0),  # #f6d6bd
		"palette_color_5": Color(0.765, 0.639, 0.541, 1.0),  # #c3a38a
		"palette_color_6": Color(0.600, 0.459, 0.467, 1.0),  # #997577
		"palette_color_7": Color(0.506, 0.384, 0.443, 1.0),  # #816271
		"palette_color_8": Color(0.306, 0.286, 0.373, 1.0),  # #4e495f
	},
	"Borkfest": {
		"palette_color_1": Color(0.875, 0.843, 0.522, 1.0),  # #dfd785
		"palette_color_2": Color(0.922, 0.761, 0.459, 1.0),  # #ebc275
		"palette_color_3": Color(0.953, 0.600, 0.286, 1.0),  # #f39949
		"palette_color_4": Color(1.0, 0.471, 0.192, 1.0),    # #ff7831
		"palette_color_5": Color(0.792, 0.353, 0.180, 1.0),  # #ca5a2e
		"palette_color_6": Color(0.588, 0.235, 0.235, 1.0),  # #963c3c
		"palette_color_7": Color(0.227, 0.157, 0.008, 1.0),  # #3a2802
		"palette_color_8": Color(0.125, 0.133, 0.082, 1.0),  # #202215
	},
	"Pollen8": {
		"palette_color_1": Color(0.451, 0.275, 0.298, 1.0),  # #73464c
		"palette_color_2": Color(0.671, 0.337, 0.459, 1.0),  # #ab5675
		"palette_color_3": Color(0.933, 0.416, 0.486, 1.0),  # #ee6a7c
		"palette_color_4": Color(1.0, 0.655, 0.647, 1.0),    # #ffa7a5
		"palette_color_5": Color(1.0, 0.878, 0.494, 1.0),    # #ffe07e
		"palette_color_6": Color(1.0, 0.906, 0.839, 1.0),    # #ffe7d6
		"palette_color_7": Color(0.447, 0.863, 0.733, 1.0),  # #72dcbb
		"palette_color_8": Color(0.204, 0.675, 0.729, 1.0),  # #34acba
	},
	"Dreamscape8": {
		"palette_color_1": Color(0.788, 0.800, 0.631, 1.0),  # #c9cca1
		"palette_color_2": Color(0.792, 0.627, 0.353, 1.0),  # #caa05a
		"palette_color_3": Color(0.682, 0.416, 0.278, 1.0),  # #ae6a47
		"palette_color_4": Color(0.545, 0.251, 0.286, 1.0),  # #8b4049
		"palette_color_5": Color(0.329, 0.200, 0.267, 1.0),  # #543344
		"palette_color_6": Color(0.318, 0.322, 0.384, 1.0),  # #515262
		"palette_color_7": Color(0.388, 0.471, 0.490, 1.0),  # #63787d
		"palette_color_8": Color(0.557, 0.627, 0.569, 1.0),  # #8ea091
	},
	"FunkyFuture 8": {
		"palette_color_1": Color(0.169, 0.059, 0.329, 1.0),  # #2b0f54
		"palette_color_2": Color(0.671, 0.122, 0.396, 1.0),  # #ab1f65
		"palette_color_3": Color(1.0, 0.310, 0.412, 1.0),    # #ff4f69
		"palette_color_4": Color(1.0, 0.969, 0.973, 1.0),    # #fff7f8
		"palette_color_5": Color(1.0, 0.506, 0.259, 1.0),    # #ff8142
		"palette_color_6": Color(1.0, 0.855, 0.271, 1.0),    # #ffda45
		"palette_color_7": Color(0.200, 0.408, 0.863, 1.0),  # #3368dc
		"palette_color_8": Color(0.286, 0.906, 0.925, 1.0),  # #49e7ec
	},
	"retrocal-8": {
		"palette_color_1": Color(0.431, 0.722, 0.659, 1.0),  # #6eb8a8
		"palette_color_2": Color(0.165, 0.345, 0.310, 1.0),  # #2a584f
		"palette_color_3": Color(0.455, 0.639, 0.247, 1.0),  # #74a33f
		"palette_color_4": Color(0.988, 1.0, 0.753, 1.0),    # #fcffc0
		"palette_color_5": Color(0.776, 0.314, 0.353, 1.0),  # #c6505a
		"palette_color_6": Color(0.184, 0.078, 0.184, 1.0),  # #2f142f
		"palette_color_7": Color(0.467, 0.267, 0.282, 1.0),  # #774448
		"palette_color_8": Color(0.933, 0.612, 0.365, 1.0),  # #ee9c5d
	},
	"CHOCOMILK-8": {
		# Using closest available chocolate/milk themed palette colors
		"palette_color_1": Color(0.180, 0.051, 0.020, 1.0),  # #2e0d05
		"palette_color_2": Color(0.365, 0.212, 0.161, 1.0),  # #5d3829
		"palette_color_3": Color(0.498, 0.322, 0.141, 1.0),  # #7f5224
		"palette_color_4": Color(0.804, 0.557, 0.318, 1.0),  # #cd8e51
		"palette_color_5": Color(0.933, 0.824, 0.439, 1.0),  # #eed29e
		"palette_color_6": Color(1.0, 0.969, 0.890, 1.0),    # #fff7e3
		"palette_color_7": Color(0.780, 0.639, 0.580, 1.0),  # #c7a394
		"palette_color_8": Color(0.776, 0.482, 0.365, 1.0),  # #c67b5d
	},
	"Rust Gold 8": {
		# Custom rust and gold themed palette
		"palette_color_1": Color(0.125, 0.078, 0.047, 1.0),  # #20140c
		"palette_color_2": Color(0.310, 0.184, 0.102, 1.0),  # #4f2f1a
		"palette_color_3": Color(0.545, 0.271, 0.129, 1.0),  # #8b4521
		"palette_color_4": Color(0.722, 0.361, 0.149, 1.0),  # #b85c26
		"palette_color_5": Color(0.871, 0.541, 0.200, 1.0),  # #de8a33
		"palette_color_6": Color(1.0, 0.722, 0.278, 1.0),    # #ffb847
		"palette_color_7": Color(1.0, 0.871, 0.549, 1.0),    # #ffde8c
		"palette_color_8": Color(1.0, 0.949, 0.800, 1.0),    # #fff2cc
	},
	"Berry Nebula": {
		# Custom berry/space themed palette
		"palette_color_1": Color(0.067, 0.024, 0.086, 1.0),  # #110616
		"palette_color_2": Color(0.184, 0.067, 0.227, 1.0),  # #2f113a
		"palette_color_3": Color(0.349, 0.133, 0.400, 1.0),  # #592266
		"palette_color_4": Color(0.565, 0.227, 0.565, 1.0),  # #903a90
		"palette_color_5": Color(0.784, 0.365, 0.647, 1.0),  # #c85da5
		"palette_color_6": Color(0.933, 0.565, 0.784, 1.0),  # #ee90c8
		"palette_color_7": Color(1.0, 0.784, 0.933, 1.0),    # #ffc8ee
		"palette_color_8": Color(1.0, 0.933, 0.984, 1.0),    # #ffeefc
	},
	"Citrink": {
		# Custom citrus/pink themed palette
		"palette_color_1": Color(0.086, 0.145, 0.094, 1.0),  # #162518
		"palette_color_2": Color(0.224, 0.349, 0.176, 1.0),  # #39592d
		"palette_color_3": Color(0.455, 0.647, 0.302, 1.0),  # #74a54d
		"palette_color_4": Color(0.733, 0.886, 0.467, 1.0),  # #bbe277
		"palette_color_5": Color(0.949, 0.976, 0.690, 1.0),  # #f2f9b0
		"palette_color_6": Color(1.0, 0.792, 0.565, 1.0),    # #ffca90
		"palette_color_7": Color(1.0, 0.565, 0.651, 1.0),    # #ff90a6
		"palette_color_8": Color(0.886, 0.365, 0.565, 1.0),  # #e25d90
	},
	"Gothic Bit": {
		# Custom gothic/dark themed palette
		"palette_color_1": Color(0.047, 0.024, 0.047, 1.0),  # #0c060c
		"palette_color_2": Color(0.118, 0.067, 0.118, 1.0),  # #1e111e
		"palette_color_3": Color(0.227, 0.133, 0.227, 1.0),  # #3a223a
		"palette_color_4": Color(0.365, 0.227, 0.365, 1.0),  # #5d3a5d
		"palette_color_5": Color(0.565, 0.365, 0.565, 1.0),  # #905d90
		"palette_color_6": Color(0.784, 0.565, 0.784, 1.0),  # #c890c8
		"palette_color_7": Color(0.933, 0.784, 0.933, 1.0),  # #eec8ee
		"palette_color_8": Color(0.976, 0.933, 0.976, 1.0),  # #f9eef9
	},
	"CL8UDS": {
		# Custom cloud/sky themed palette
		"palette_color_1": Color(0.133, 0.184, 0.267, 1.0),  # #222f44
		"palette_color_2": Color(0.227, 0.318, 0.467, 1.0),  # #3a5177
		"palette_color_3": Color(0.365, 0.486, 0.686, 1.0),  # #5d7caf
		"palette_color_4": Color(0.565, 0.686, 0.871, 1.0),  # #90afde
		"palette_color_5": Color(0.784, 0.871, 0.976, 1.0),  # #c8def9
		"palette_color_6": Color(0.933, 0.949, 1.0, 1.0),    # #eef2ff
		"palette_color_7": Color(1.0, 0.976, 0.933, 1.0),    # #fff9ee
		"palette_color_8": Color(1.0, 0.933, 0.784, 1.0),    # #ffeec8
	},
	"Paper 8": {
		# Custom paper/vintage themed palette
		"palette_color_1": Color(0.094, 0.078, 0.067, 1.0),  # #181411
		"palette_color_2": Color(0.227, 0.196, 0.169, 1.0),  # #3a322b
		"palette_color_3": Color(0.400, 0.349, 0.306, 1.0),  # #66594e
		"palette_color_4": Color(0.600, 0.533, 0.478, 1.0),  # #99887a
		"palette_color_5": Color(0.784, 0.722, 0.667, 1.0),  # #c8b8aa
		"palette_color_6": Color(0.918, 0.878, 0.839, 1.0),  # #eae0d6
		"palette_color_7": Color(0.976, 0.949, 0.922, 1.0),  # #f9f2eb
		"palette_color_8": Color(1.0, 0.988, 0.976, 1.0),    # #fffcf9
	},
	"Seafoam": {
		# Custom seafoam/ocean themed palette
		"palette_color_1": Color(0.024, 0.086, 0.094, 1.0),  # #061618
		"palette_color_2": Color(0.067, 0.184, 0.200, 1.0),  # #112f33
		"palette_color_3": Color(0.133, 0.318, 0.349, 1.0),  # #225159
		"palette_color_4": Color(0.227, 0.486, 0.533, 1.0),  # #3a7c88
		"palette_color_5": Color(0.365, 0.686, 0.733, 1.0),  # #5dafbb
		"palette_color_6": Color(0.565, 0.871, 0.886, 1.0),  # #90dee2
		"palette_color_7": Color(0.784, 0.976, 0.976, 1.0),  # #c8f9f9
		"palette_color_8": Color(0.933, 1.0, 1.0, 1.0),      # #eeffff
	},
	"Ammo-8": {
		# Custom military/ammo themed palette
		"palette_color_1": Color(0.067, 0.086, 0.047, 1.0),  # #11160c
		"palette_color_2": Color(0.149, 0.200, 0.118, 1.0),  # #26331e
		"palette_color_3": Color(0.267, 0.349, 0.200, 1.0),  # #445933
		"palette_color_4": Color(0.400, 0.533, 0.302, 1.0),  # #66884d
		"palette_color_5": Color(0.565, 0.733, 0.435, 1.0),  # #90bb6f
		"palette_color_6": Color(0.733, 0.886, 0.600, 1.0),  # #bbe299
		"palette_color_7": Color(0.871, 0.976, 0.784, 1.0),  # #def9c8
		"palette_color_8": Color(0.949, 1.0, 0.918, 1.0),    # #f2ffea
	}
}

# Get all color preset names
static func get_color_preset_names() -> Array[String]:
	var names: Array[String] = []
	for name in COLOR_PRESETS.keys():
		names.append(name)
	return names

# Get a specific color preset by name
static func get_color_preset(name: String) -> Dictionary:
	return COLOR_PRESETS.get(name, {})

# Check if a color preset exists
static func has_color_preset(name: String) -> bool:
	return COLOR_PRESETS.has(name)

# Get all color presets
static func get_all_color_presets() -> Dictionary:
	return COLOR_PRESETS.duplicate(true) 
