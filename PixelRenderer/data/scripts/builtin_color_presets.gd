class_name BuiltinColorPresets
extends RefCounted

# Built-in color palette presets from popular Lospec palettes
# Each preset contains only the 8 palette colors, formatted for the pixel material system
# 
# Extended support for 256-color palettes (v4.6):
# - The "PIX256" preset contains a 256-color palette spread across multiple entries
# - The shader now supports up to 64 colors via palette_color_1 through palette_color_64
# - Use palette_color_count uniform in shader to select active palette size (2-64)
# - For color selection from 256-color palette, create custom presets or use color sampling

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
	},
	"PIX256": {
		# 256-color palette - all colors in one palette
		"palette_color_1": Color(0.0, 0.0, 0.0, 1.0), #000000
		"palette_color_2": Color(0.133, 0.137, 0.137, 1.0), #222323
		"palette_color_3": Color(0.263, 0.271, 0.286, 1.0), #434549
		"palette_color_4": Color(0.384, 0.408, 0.443, 1.0), #626871
		"palette_color_5": Color(0.510, 0.545, 0.596, 1.0), #828b98
		"palette_color_6": Color(0.651, 0.682, 0.729, 1.0), #a6aeba
		"palette_color_7": Color(0.804, 0.824, 0.855, 1.0), #cdd2da
		"palette_color_8": Color(0.961, 0.969, 0.980, 1.0), #f5f7fa
		"palette_color_9": Color(0.384, 0.365, 0.329, 1.0), #625d54
		"palette_color_10": Color(0.522, 0.459, 0.396, 1.0), #857565
		"palette_color_11": Color(0.620, 0.549, 0.475, 1.0), #9e8c79
		"palette_color_12": Color(0.682, 0.631, 0.537, 1.0), #aea189
		"palette_color_13": Color(0.733, 0.686, 0.643, 1.0), #bbafa4
		"palette_color_14": Color(0.800, 0.765, 0.694, 1.0), #ccc3b1
		"palette_color_15": Color(0.918, 0.859, 0.788, 1.0), #eadbc9
		"palette_color_16": Color(1.0, 0.953, 0.839, 1.0), #fff3d6
		"palette_color_17": Color(0.345, 0.192, 0.149, 1.0), #583126
		"palette_color_18": Color(0.451, 0.239, 0.231, 1.0), #733d3b
		"palette_color_19": Color(0.533, 0.314, 0.255, 1.0), #885041
		"palette_color_20": Color(0.604, 0.384, 0.298, 1.0), #9a624c
		"palette_color_21": Color(0.678, 0.431, 0.318, 1.0), #ad6e51
		"palette_color_22": Color(0.835, 0.553, 0.420, 1.0), #d58d6b
		"palette_color_23": Color(0.984, 0.667, 0.518, 1.0), #fbaa84
		"palette_color_24": Color(1.0, 0.808, 0.498, 1.0), #ffce7f
		"palette_color_25": Color(0.0, 0.153, 0.208, 1.0), #002735
		"palette_color_26": Color(0.0, 0.220, 0.314, 1.0), #003850
		"palette_color_27": Color(0.0, 0.302, 0.369, 1.0), #004d5e
		"palette_color_28": Color(0.043, 0.400, 0.498, 1.0), #0b667f
		"palette_color_29": Color(0.0, 0.435, 0.537, 1.0), #006f89
		"palette_color_30": Color(0.196, 0.549, 0.655, 1.0), #328ca7
		"palette_color_31": Color(0.141, 0.682, 0.839, 1.0), #24aed6
		"palette_color_32": Color(0.533, 0.839, 1.0, 1.0), #88d6ff
		"palette_color_33": Color(0.400, 0.169, 0.161, 1.0), #662b29
		"palette_color_34": Color(0.580, 0.212, 0.227, 1.0), #94363a
		"palette_color_35": Color(0.714, 0.302, 0.275, 1.0), #b64d46
		"palette_color_36": Color(0.804, 0.369, 0.275, 1.0), #cd5e46
		"palette_color_37": Color(0.890, 0.471, 0.251, 1.0), #e37840
		"palette_color_38": Color(0.976, 0.608, 0.306, 1.0), #f99b4e
		"palette_color_39": Color(1.0, 0.737, 0.306, 1.0), #ffbc4e
		"palette_color_40": Color(1.0, 0.914, 0.286, 1.0), #ffe949
		"palette_color_41": Color(0.157, 0.169, 0.290, 1.0), #282b4a
		"palette_color_42": Color(0.227, 0.271, 0.408, 1.0), #3a4568
		"palette_color_43": Color(0.380, 0.373, 0.518, 1.0), #615f84
		"palette_color_44": Color(0.478, 0.467, 0.600, 1.0), #7a7799
		"palette_color_45": Color(0.525, 0.565, 0.698, 1.0), #8690b2
		"palette_color_46": Color(0.588, 0.698, 0.851, 1.0), #96b2d9
		"palette_color_47": Color(0.780, 0.839, 1.0, 1.0), #c7d6ff
		"palette_color_48": Color(0.776, 0.925, 1.0, 1.0), #c6ecff
		"palette_color_49": Color(0.0, 0.133, 0.098, 1.0), #002219
		"palette_color_50": Color(0.0, 0.196, 0.129, 1.0), #003221
		"palette_color_51": Color(0.090, 0.290, 0.106, 1.0), #174a1b
		"palette_color_52": Color(0.133, 0.349, 0.094, 1.0), #225918
		"palette_color_53": Color(0.184, 0.412, 0.047, 1.0), #2f690c
		"palette_color_54": Color(0.318, 0.533, 0.133, 1.0), #518822
		"palette_color_55": Color(0.490, 0.643, 0.176, 1.0), #7da42d
		"palette_color_56": Color(0.651, 0.800, 0.204, 1.0), #a6cc34
		"palette_color_57": Color(0.094, 0.122, 0.184, 1.0), #181f2f
		"palette_color_58": Color(0.137, 0.196, 0.302, 1.0), #23324d
		"palette_color_59": Color(0.145, 0.275, 0.420, 1.0), #25466b
		"palette_color_60": Color(0.212, 0.420, 0.541, 1.0), #366b8a
		"palette_color_61": Color(0.192, 0.557, 0.722, 1.0), #318eb8
		"palette_color_62": Color(0.255, 0.698, 0.890, 1.0), #41b2e3
		"palette_color_63": Color(0.322, 0.824, 1.0, 1.0), #52d2ff
		"palette_color_64": Color(0.455, 0.961, 0.992, 1.0), #74f5fd
		"palette_color_65": Color(0.102, 0.200, 0.173, 1.0), #1a332c
		"palette_color_66": Color(0.184, 0.247, 0.220, 1.0), #2f3f38
		"palette_color_67": Color(0.220, 0.318, 0.251, 1.0), #385140
		"palette_color_68": Color(0.196, 0.361, 0.251, 1.0), #325c40
		"palette_color_69": Color(0.255, 0.455, 0.333, 1.0), #417455
		"palette_color_70": Color(0.286, 0.537, 0.376, 1.0), #498960
		"palette_color_71": Color(0.333, 0.714, 0.490, 1.0), #55b67d
		"palette_color_72": Color(0.569, 0.855, 0.631, 1.0), #91daa1
		"palette_color_73": Color(0.369, 0.027, 0.067, 1.0), #5e0711
		"palette_color_74": Color(0.510, 0.129, 0.114, 1.0), #82211d
		"palette_color_75": Color(0.714, 0.235, 0.208, 1.0), #b63c35
		"palette_color_76": Color(0.894, 0.361, 0.373, 1.0), #e45c5f
		"palette_color_77": Color(1.0, 0.463, 0.463, 1.0), #ff7676
		"palette_color_78": Color(1.0, 0.608, 0.659, 1.0), #ff9ba8
		"palette_color_79": Color(1.0, 0.733, 0.780, 1.0), #ffbbc7
		"palette_color_80": Color(1.0, 0.859, 1.0, 1.0), #ffdbff
		"palette_color_81": Color(0.176, 0.192, 0.212, 1.0), #2d3136
		"palette_color_82": Color(0.282, 0.278, 0.302, 1.0), #48474d
		"palette_color_83": Color(0.357, 0.361, 0.412, 1.0), #5b5c69
		"palette_color_84": Color(0.451, 0.451, 0.498, 1.0), #73737f
		"palette_color_85": Color(0.518, 0.529, 0.584, 1.0), #848795
		"palette_color_86": Color(0.671, 0.682, 0.745, 1.0), #abaebe
		"palette_color_87": Color(0.729, 0.780, 0.859, 1.0), #bac7db
		"palette_color_88": Color(0.922, 0.941, 0.965, 1.0), #ebf0f6
		"palette_color_89": Color(0.231, 0.188, 0.235, 1.0), #3b303c
		"palette_color_90": Color(0.353, 0.235, 0.271, 1.0), #5a3c45
		"palette_color_91": Color(0.541, 0.322, 0.345, 1.0), #8a5258
		"palette_color_92": Color(0.682, 0.420, 0.376, 1.0), #ae6b60
		"palette_color_93": Color(0.780, 0.510, 0.424, 1.0), #c7826c
		"palette_color_94": Color(0.847, 0.624, 0.459, 1.0), #d89f75
		"palette_color_95": Color(0.925, 0.773, 0.506, 1.0), #ecc581
		"palette_color_96": Color(1.0, 0.980, 0.671, 1.0), #fffaab
		"palette_color_97": Color(0.192, 0.133, 0.165, 1.0), #31222a
		"palette_color_98": Color(0.290, 0.208, 0.235, 1.0), #4a353c
		"palette_color_99": Color(0.369, 0.275, 0.275, 1.0), #5e4646
		"palette_color_100": Color(0.447, 0.353, 0.318, 1.0), #725a51
		"palette_color_101": Color(0.494, 0.424, 0.329, 1.0), #7e6c54
		"palette_color_102": Color(0.620, 0.541, 0.431, 1.0), #9e8a6e
		"palette_color_103": Color(0.753, 0.647, 0.533, 1.0), #c0a588
		"palette_color_104": Color(0.867, 0.749, 0.604, 1.0), #ddbf9a
		"palette_color_105": Color(0.180, 0.063, 0.149, 1.0), #2e1026
		"palette_color_106": Color(0.286, 0.157, 0.239, 1.0), #49283d
		"palette_color_107": Color(0.400, 0.212, 0.349, 1.0), #663659
		"palette_color_108": Color(0.592, 0.329, 0.459, 1.0), #975475
		"palette_color_109": Color(0.725, 0.427, 0.569, 1.0), #b96d91
		"palette_color_110": Color(0.757, 0.471, 0.667, 1.0), #c178aa
		"palette_color_111": Color(0.859, 0.600, 0.749, 1.0), #db99bf
		"palette_color_112": Color(0.973, 0.776, 0.855, 1.0), #f8c6da
		"palette_color_113": Color(0.0, 0.180, 0.286, 1.0), #002e49
		"palette_color_114": Color(0.0, 0.251, 0.318, 1.0), #004051
		"palette_color_115": Color(0.0, 0.318, 0.384, 1.0), #005162
		"palette_color_116": Color(0.0, 0.420, 0.427, 1.0), #006b6d
		"palette_color_117": Color(0.0, 0.510, 0.475, 1.0), #008279
		"palette_color_118": Color(0.0, 0.627, 0.529, 1.0), #00a087
		"palette_color_119": Color(0.0, 0.749, 0.639, 1.0), #00bfa3
		"palette_color_120": Color(0.0, 0.871, 0.855, 1.0), #00deda
		"palette_color_121": Color(0.271, 0.192, 0.145, 1.0), #453125
		"palette_color_122": Color(0.380, 0.290, 0.235, 1.0), #614a3c
		"palette_color_123": Color(0.494, 0.380, 0.267, 1.0), #7e6144
		"palette_color_124": Color(0.600, 0.475, 0.318, 1.0), #997951
		"palette_color_125": Color(0.698, 0.565, 0.384, 1.0), #b29062
		"palette_color_126": Color(0.800, 0.663, 0.431, 1.0), #cca96e
		"palette_color_127": Color(0.910, 0.796, 0.510, 1.0), #e8cb82
		"palette_color_128": Color(0.984, 0.918, 0.639, 1.0), #fbeaa3
		"palette_color_129": Color(0.373, 0.035, 0.149, 1.0), #5f0926
		"palette_color_130": Color(0.431, 0.141, 0.204, 1.0), #6e2434
		"palette_color_131": Color(0.565, 0.275, 0.278, 1.0), #904647
		"palette_color_132": Color(0.655, 0.376, 0.341, 1.0), #a76057
		"palette_color_133": Color(0.741, 0.490, 0.392, 1.0), #bd7d64
		"palette_color_134": Color(0.808, 0.592, 0.439, 1.0), #ce9770
		"palette_color_135": Color(0.929, 0.714, 0.486, 1.0), #edb67c
		"palette_color_136": Color(0.929, 0.831, 0.576, 1.0), #edd493
		"palette_color_137": Color(0.196, 0.208, 0.345, 1.0), #323558
		"palette_color_138": Color(0.290, 0.322, 0.502, 1.0), #4a5280
		"palette_color_139": Color(0.392, 0.396, 0.616, 1.0), #64659d
		"palette_color_140": Color(0.471, 0.467, 0.757, 1.0), #7877c1
		"palette_color_141": Color(0.557, 0.549, 0.886, 1.0), #8e8ce2
		"palette_color_142": Color(0.612, 0.608, 0.937, 1.0), #9c9bef
		"palette_color_143": Color(0.722, 0.682, 1.0, 1.0), #b8aeff
		"palette_color_144": Color(0.863, 0.831, 1.0, 1.0), #dcd4ff
		"palette_color_145": Color(0.263, 0.090, 0.161, 1.0), #431729
		"palette_color_146": Color(0.443, 0.169, 0.231, 1.0), #712b3b
		"palette_color_147": Color(0.624, 0.231, 0.322, 1.0), #9f3b52
		"palette_color_148": Color(0.851, 0.290, 0.412, 1.0), #d94a69
		"palette_color_149": Color(0.973, 0.365, 0.502, 1.0), #f85d80
		"palette_color_150": Color(1.0, 0.490, 0.686, 1.0), #ff7daf
		"palette_color_151": Color(1.0, 0.651, 0.773, 1.0), #ffa6c5
		"palette_color_152": Color(1.0, 0.804, 1.0, 1.0), #ffcdff
		"palette_color_153": Color(0.286, 0.145, 0.110, 1.0), #49251c
		"palette_color_154": Color(0.388, 0.204, 0.196, 1.0), #633432
		"palette_color_155": Color(0.486, 0.294, 0.278, 1.0), #7c4b47
		"palette_color_156": Color(0.596, 0.349, 0.353, 1.0), #98595a
		"palette_color_157": Color(0.675, 0.435, 0.431, 1.0), #ac6f6e
		"palette_color_158": Color(0.757, 0.494, 0.478, 1.0), #c17e7a
		"palette_color_159": Color(0.824, 0.553, 0.478, 1.0), #d28d7a
		"palette_color_160": Color(0.898, 0.604, 0.486, 1.0), #e59a7c
		"palette_color_161": Color(0.125, 0.161, 0.0, 1.0), #202900
		"palette_color_162": Color(0.184, 0.310, 0.031, 1.0), #2f4f08
		"palette_color_163": Color(0.286, 0.365, 0.0, 1.0), #495d00
		"palette_color_164": Color(0.380, 0.451, 0.031, 1.0), #617308
		"palette_color_165": Color(0.486, 0.514, 0.118, 1.0), #7c831e
		"palette_color_166": Color(0.588, 0.604, 0.149, 1.0), #969a26
		"palette_color_167": Color(0.706, 0.667, 0.200, 1.0), #b4aa33
		"palette_color_168": Color(0.816, 0.800, 0.196, 1.0), #d0cc32
		"palette_color_169": Color(0.384, 0.165, 0.0, 1.0), #622a00
		"palette_color_170": Color(0.459, 0.231, 0.035, 1.0), #753b09
		"palette_color_171": Color(0.522, 0.310, 0.071, 1.0), #854f12
		"palette_color_172": Color(0.620, 0.396, 0.125, 1.0), #9e6520
		"palette_color_173": Color(0.729, 0.533, 0.180, 1.0), #ba882e
		"palette_color_174": Color(0.820, 0.667, 0.224, 1.0), #d1aa39
		"palette_color_175": Color(0.910, 0.824, 0.294, 1.0), #e8d24b
		"palette_color_176": Color(1.0, 0.965, 0.310, 1.0), #fff64f
		"palette_color_177": Color(0.149, 0.137, 0.239, 1.0), #26233d
		"palette_color_178": Color(0.231, 0.220, 0.333, 1.0), #3b3855
		"palette_color_179": Color(0.337, 0.314, 0.435, 1.0), #56506f
		"palette_color_180": Color(0.459, 0.408, 0.431, 1.0), #75686e
		"palette_color_181": Color(0.569, 0.478, 0.482, 1.0), #917a7b
		"palette_color_182": Color(0.702, 0.592, 0.514, 1.0), #b39783
		"palette_color_183": Color(0.812, 0.686, 0.557, 1.0), #cfaf8e
		"palette_color_184": Color(0.996, 0.875, 0.694, 1.0), #fedfb1
		"palette_color_185": Color(0.114, 0.173, 0.263, 1.0), #1d2c43
		"palette_color_186": Color(0.180, 0.239, 0.278, 1.0), #2e3d47
		"palette_color_187": Color(0.224, 0.302, 0.235, 1.0), #394d3c
		"palette_color_188": Color(0.298, 0.373, 0.200, 1.0), #4c5f33
		"palette_color_189": Color(0.345, 0.443, 0.173, 1.0), #58712c
		"palette_color_190": Color(0.420, 0.518, 0.176, 1.0), #6b842d
		"palette_color_191": Color(0.471, 0.620, 0.141, 1.0), #789e24
		"palette_color_192": Color(0.498, 0.741, 0.224, 1.0), #7fbd39
		"palette_color_193": Color(0.216, 0.141, 0.137, 1.0), #372423
		"palette_color_194": Color(0.325, 0.224, 0.227, 1.0), #53393a
		"palette_color_195": Color(0.471, 0.298, 0.286, 1.0), #784c49
		"palette_color_196": Color(0.580, 0.365, 0.310, 1.0), #945d4f
		"palette_color_197": Color(0.663, 0.427, 0.345, 1.0), #a96d58
		"palette_color_198": Color(0.749, 0.494, 0.380, 1.0), #bf7e63
		"palette_color_199": Color(0.843, 0.576, 0.455, 1.0), #d79374
		"palette_color_200": Color(0.957, 0.639, 0.502, 1.0), #f4a380
		"palette_color_201": Color(0.176, 0.294, 0.278, 1.0), #2d4b47
		"palette_color_202": Color(0.278, 0.396, 0.353, 1.0), #47655a
		"palette_color_203": Color(0.357, 0.482, 0.412, 1.0), #5b7b69
		"palette_color_204": Color(0.443, 0.584, 0.490, 1.0), #71957d
		"palette_color_205": Color(0.529, 0.682, 0.557, 1.0), #87ae8e
		"palette_color_206": Color(0.541, 0.757, 0.588, 1.0), #8ac196
		"palette_color_207": Color(0.663, 0.820, 0.757, 1.0), #a9d1c1
		"palette_color_208": Color(0.878, 0.980, 0.922, 1.0), #e0faeb
		"palette_color_209": Color(0.0, 0.106, 0.251, 1.0), #001b40
		"palette_color_210": Color(0.012, 0.192, 0.373, 1.0), #03315f
		"palette_color_211": Color(0.027, 0.282, 0.486, 1.0), #07487c
		"palette_color_212": Color(0.063, 0.365, 0.635, 1.0), #105da2
		"palette_color_213": Color(0.078, 0.463, 0.753, 1.0), #1476c0
		"palette_color_214": Color(0.251, 0.592, 0.918, 1.0), #4097ea
		"palette_color_215": Color(0.333, 0.694, 0.945, 1.0), #55b1f1
		"palette_color_216": Color(0.427, 0.800, 1.0, 1.0), #6dccff
		"palette_color_217": Color(0.333, 0.278, 0.412, 1.0), #554769
		"palette_color_218": Color(0.463, 0.365, 0.451, 1.0), #765d73
		"palette_color_219": Color(0.592, 0.455, 0.533, 1.0), #977488
		"palette_color_220": Color(0.725, 0.549, 0.576, 1.0), #b98c93
		"palette_color_221": Color(0.835, 0.639, 0.604, 1.0), #d5a39a
		"palette_color_222": Color(0.922, 0.741, 0.616, 1.0), #ebbd9d
		"palette_color_223": Color(1.0, 0.835, 0.608, 1.0), #ffd59b
		"palette_color_224": Color(0.992, 0.969, 0.525, 1.0), #fdf786
		"palette_color_225": Color(0.114, 0.114, 0.129, 1.0), #1d1d21
		"palette_color_226": Color(0.235, 0.192, 0.318, 1.0), #3c3151
		"palette_color_227": Color(0.345, 0.290, 0.498, 1.0), #584a7f
		"palette_color_228": Color(0.475, 0.392, 0.729, 1.0), #7964ba
		"palette_color_229": Color(0.584, 0.522, 0.945, 1.0), #9585f1
		"palette_color_230": Color(0.663, 0.588, 0.925, 1.0), #a996ec
		"palette_color_231": Color(0.729, 0.671, 0.969, 1.0), #baabf7
		"palette_color_232": Color(0.820, 0.741, 0.996, 1.0), #d1bdfe
		"palette_color_233": Color(0.149, 0.141, 0.314, 1.0), #262450
		"palette_color_234": Color(0.157, 0.200, 0.365, 1.0), #28335d
		"palette_color_235": Color(0.176, 0.239, 0.447, 1.0), #2d3d72
		"palette_color_236": Color(0.239, 0.314, 0.514, 1.0), #3d5083
		"palette_color_237": Color(0.318, 0.396, 0.682, 1.0), #5165ae
		"palette_color_238": Color(0.322, 0.455, 0.773, 1.0), #5274c5
		"palette_color_239": Color(0.424, 0.510, 0.769, 1.0), #6c82c4
		"palette_color_240": Color(0.514, 0.576, 0.765, 1.0), #8393c3
		"palette_color_241": Color(0.286, 0.129, 0.161, 1.0), #492129
		"palette_color_242": Color(0.369, 0.255, 0.290, 1.0), #5e414a
		"palette_color_243": Color(0.467, 0.325, 0.357, 1.0), #77535b
		"palette_color_244": Color(0.569, 0.376, 0.416, 1.0), #91606a
		"palette_color_245": Color(0.678, 0.475, 0.518, 1.0), #ad7984
		"palette_color_246": Color(0.710, 0.545, 0.580, 1.0), #b58b94
		"palette_color_247": Color(0.831, 0.682, 0.667, 1.0), #d4aeaa
		"palette_color_248": Color(1.0, 0.886, 0.812, 1.0), #ffe2cf
		"palette_color_249": Color(0.447, 0.110, 0.012, 1.0), #721c03
		"palette_color_250": Color(0.612, 0.200, 0.153, 1.0), #9c3327
		"palette_color_251": Color(0.749, 0.353, 0.243, 1.0), #bf5a3e
		"palette_color_252": Color(0.914, 0.525, 0.153, 1.0), #e98627
		"palette_color_253": Color(1.0, 0.694, 0.031, 1.0), #ffb108
		"palette_color_254": Color(1.0, 0.812, 0.020, 1.0), #ffcf05
		"palette_color_255": Color(1.0, 0.941, 0.169, 1.0), #fff02b
		"palette_color_256": Color(0.969, 0.957, 0.749, 1.0) #f7f4bf
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