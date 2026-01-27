shader_type canvas_item;

// PixelArt Shader for Godot 4.6 with 256-color palette support (v4.6)
// Supports up to 64 colors in shader (can be extended further if needed)
// Use palette_color_count uniform to select how many colors from the palette to use (2-64)
// Extended color presets available: PIX256 (256 colors) in builtin_color_presets.gd

// Pixelation
uniform int target_pixel_count : hint_range(8, 800) = 256;

// Color reduction
uniform int color_steps : hint_range(2, 32) = 8;

// Edge detection and sharpening
uniform float edge_strength : hint_range(0.0, 2.0) = 0.5;
uniform float sharpness : hint_range(0.0, 3.0) = 1.0;

// HSV adjustments
uniform float hue_shift : hint_range(-180.0, 180.0) = 0.0;
uniform float saturation : hint_range(0.0, 2.0) = 1.0;
uniform float value_brightness : hint_range(0.0, 2.0) = 1.0;

// Contrast and other adjustments
uniform float contrast : hint_range(0.0, 3.0) = 1.0;
uniform float gamma : hint_range(0.1, 3.0) = 1.0;
uniform float brightness : hint_range(-1.0, 1.0) = 0.0;

// Outline
uniform float outline_thickness : hint_range(0.0, 20.0) = 0.0;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

// Dithering
uniform float dither_amount : hint_range(0.0, 1.0) = 0.5;
uniform float dither_blend : hint_range(0.0, 1.0) = 1.0;
uniform float dither_threshold : hint_range(0.0, 1.0) = 0.5;
uniform float shadow_sensitivity : hint_range(0.1, 2.0) = 1.0;
uniform float dot_size : hint_range(0.1, 2.0) = 1.0;
uniform vec4 dither_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

// Palette constraints
uniform bool use_palette = true;
uniform int palette_color_count : hint_range(2, 256) = 8;
uniform vec4 palette_color_1 : source_color = vec4(0.051, 0.169, 0.271, 1.0);  // #0d2b45
uniform vec4 palette_color_2 : source_color = vec4(0.125, 0.235, 0.337, 1.0);  // #203c56
uniform vec4 palette_color_3 : source_color = vec4(0.329, 0.306, 0.408, 1.0);  // #544e68
uniform vec4 palette_color_4 : source_color = vec4(0.553, 0.412, 0.478, 1.0);  // #8d697a
uniform vec4 palette_color_5 : source_color = vec4(0.816, 0.506, 0.349, 1.0);  // #d08159
uniform vec4 palette_color_6 : source_color = vec4(1.0, 0.667, 0.369, 1.0);    // #ffaa5e
uniform vec4 palette_color_7 : source_color = vec4(1.0, 0.831, 0.639, 1.0);    // #ffd4a3
uniform vec4 palette_color_8 : source_color = vec4(1.0, 0.925, 0.839, 1.0);    // #ffecd6
uniform vec4 palette_color_9 : source_color = vec4(0.384, 0.365, 0.329, 1.0);
uniform vec4 palette_color_10 : source_color = vec4(0.522, 0.459, 0.396, 1.0);
uniform vec4 palette_color_11 : source_color = vec4(0.620, 0.549, 0.475, 1.0);
uniform vec4 palette_color_12 : source_color = vec4(0.682, 0.631, 0.537, 1.0);
uniform vec4 palette_color_13 : source_color = vec4(0.733, 0.686, 0.643, 1.0);
uniform vec4 palette_color_14 : source_color = vec4(0.800, 0.765, 0.694, 1.0);
uniform vec4 palette_color_15 : source_color = vec4(0.918, 0.859, 0.788, 1.0);
uniform vec4 palette_color_16 : source_color = vec4(1.0, 0.953, 0.839, 1.0);
uniform vec4 palette_color_17 : source_color = vec4(0.345, 0.192, 0.149, 1.0);
uniform vec4 palette_color_18 : source_color = vec4(0.451, 0.239, 0.231, 1.0);
uniform vec4 palette_color_19 : source_color = vec4(0.533, 0.314, 0.255, 1.0);
uniform vec4 palette_color_20 : source_color = vec4(0.604, 0.384, 0.298, 1.0);
uniform vec4 palette_color_21 : source_color = vec4(0.678, 0.431, 0.318, 1.0);
uniform vec4 palette_color_22 : source_color = vec4(0.835, 0.553, 0.420, 1.0);
uniform vec4 palette_color_23 : source_color = vec4(0.984, 0.667, 0.518, 1.0);
uniform vec4 palette_color_24 : source_color = vec4(1.0, 0.808, 0.498, 1.0);
uniform vec4 palette_color_25 : source_color = vec4(0.0, 0.153, 0.208, 1.0);
uniform vec4 palette_color_26 : source_color = vec4(0.0, 0.220, 0.314, 1.0);
uniform vec4 palette_color_27 : source_color = vec4(0.0, 0.302, 0.369, 1.0);
uniform vec4 palette_color_28 : source_color = vec4(0.043, 0.400, 0.498, 1.0);
uniform vec4 palette_color_29 : source_color = vec4(0.0, 0.435, 0.537, 1.0);
uniform vec4 palette_color_30 : source_color = vec4(0.196, 0.549, 0.655, 1.0);
uniform vec4 palette_color_31 : source_color = vec4(0.141, 0.682, 0.839, 1.0);
uniform vec4 palette_color_32 : source_color = vec4(0.533, 0.839, 1.0, 1.0);
uniform vec4 palette_color_33 : source_color = vec4(0.400, 0.169, 0.161, 1.0);
uniform vec4 palette_color_34 : source_color = vec4(0.580, 0.212, 0.227, 1.0);
uniform vec4 palette_color_35 : source_color = vec4(0.714, 0.302, 0.275, 1.0);
uniform vec4 palette_color_36 : source_color = vec4(0.804, 0.369, 0.275, 1.0);
uniform vec4 palette_color_37 : source_color = vec4(0.890, 0.471, 0.251, 1.0);
uniform vec4 palette_color_38 : source_color = vec4(0.976, 0.608, 0.306, 1.0);
uniform vec4 palette_color_39 : source_color = vec4(1.0, 0.737, 0.306, 1.0);
uniform vec4 palette_color_40 : source_color = vec4(1.0, 0.914, 0.286, 1.0);
uniform vec4 palette_color_41 : source_color = vec4(0.157, 0.169, 0.290, 1.0);
uniform vec4 palette_color_42 : source_color = vec4(0.227, 0.271, 0.408, 1.0);
uniform vec4 palette_color_43 : source_color = vec4(0.380, 0.373, 0.518, 1.0);
uniform vec4 palette_color_44 : source_color = vec4(0.478, 0.467, 0.600, 1.0);
uniform vec4 palette_color_45 : source_color = vec4(0.525, 0.565, 0.698, 1.0);
uniform vec4 palette_color_46 : source_color = vec4(0.588, 0.698, 0.851, 1.0);
uniform vec4 palette_color_47 : source_color = vec4(0.780, 0.839, 1.0, 1.0);
uniform vec4 palette_color_48 : source_color = vec4(0.776, 0.925, 1.0, 1.0);
uniform vec4 palette_color_49 : source_color = vec4(0.0, 0.133, 0.098, 1.0);
uniform vec4 palette_color_50 : source_color = vec4(0.0, 0.196, 0.129, 1.0);
uniform vec4 palette_color_51 : source_color = vec4(0.090, 0.290, 0.106, 1.0);
uniform vec4 palette_color_52 : source_color = vec4(0.133, 0.349, 0.094, 1.0);
uniform vec4 palette_color_53 : source_color = vec4(0.184, 0.412, 0.047, 1.0);
uniform vec4 palette_color_54 : source_color = vec4(0.318, 0.533, 0.133, 1.0);
uniform vec4 palette_color_55 : source_color = vec4(0.490, 0.643, 0.176, 1.0);
uniform vec4 palette_color_56 : source_color = vec4(0.651, 0.800, 0.204, 1.0);
uniform vec4 palette_color_57 : source_color = vec4(0.094, 0.122, 0.184, 1.0);
uniform vec4 palette_color_58 : source_color = vec4(0.137, 0.196, 0.302, 1.0);
uniform vec4 palette_color_59 : source_color = vec4(0.145, 0.275, 0.420, 1.0);
uniform vec4 palette_color_60 : source_color = vec4(0.212, 0.420, 0.541, 1.0);
uniform vec4 palette_color_61 : source_color = vec4(0.192, 0.557, 0.722, 1.0);
uniform vec4 palette_color_62 : source_color = vec4(0.255, 0.698, 0.890, 1.0);
uniform vec4 palette_color_63 : source_color = vec4(0.322, 0.824, 1.0, 1.0);
uniform vec4 palette_color_64 : source_color = vec4(0.455, 0.961, 0.992, 1.0);

// Utility functions
vec3 rgb_to_hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv_to_rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 quantize_color(vec3 color) {
    float step_size = 1.0 / float(color_steps - 1);
    return floor(color / step_size) * step_size;
}

vec3 apply_palette(vec3 color) {
    if (!use_palette) return color;

    vec3 colors[64] = vec3[64](
        palette_color_1.rgb,
        palette_color_2.rgb,
        palette_color_3.rgb,
        palette_color_4.rgb,
        palette_color_5.rgb,
        palette_color_6.rgb,
        palette_color_7.rgb,
        palette_color_8.rgb,
        palette_color_9.rgb,
        palette_color_10.rgb,
        palette_color_11.rgb,
        palette_color_12.rgb,
        palette_color_13.rgb,
        palette_color_14.rgb,
        palette_color_15.rgb,
        palette_color_16.rgb,
        palette_color_17.rgb,
        palette_color_18.rgb,
        palette_color_19.rgb,
        palette_color_20.rgb,
        palette_color_21.rgb,
        palette_color_22.rgb,
        palette_color_23.rgb,
        palette_color_24.rgb,
        palette_color_25.rgb,
        palette_color_26.rgb,
        palette_color_27.rgb,
        palette_color_28.rgb,
        palette_color_29.rgb,
        palette_color_30.rgb,
        palette_color_31.rgb,
        palette_color_32.rgb,
        palette_color_33.rgb,
        palette_color_34.rgb,
        palette_color_35.rgb,
        palette_color_36.rgb,
        palette_color_37.rgb,
        palette_color_38.rgb,
        palette_color_39.rgb,
        palette_color_40.rgb,
        palette_color_41.rgb,
        palette_color_42.rgb,
        palette_color_43.rgb,
        palette_color_44.rgb,
        palette_color_45.rgb,
        palette_color_46.rgb,
        palette_color_47.rgb,
        palette_color_48.rgb,
        palette_color_49.rgb,
        palette_color_50.rgb,
        palette_color_51.rgb,
        palette_color_52.rgb,
        palette_color_53.rgb,
        palette_color_54.rgb,
        palette_color_55.rgb,
        palette_color_56.rgb,
        palette_color_57.rgb,
        palette_color_58.rgb,
        palette_color_59.rgb,
        palette_color_60.rgb,
        palette_color_61.rgb,
        palette_color_62.rgb,
        palette_color_63.rgb,
        palette_color_64.rgb
    );

    float min_dist = 10.0;
    vec3 closest_color = colors[0];

    for (int i = 0; i < 64; i++) {
        if (i >= palette_color_count) break;
        float dist = distance(color, colors[i]);
        if (dist < min_dist) {
            min_dist = dist;
            closest_color = colors[i];
        }
    }

    return closest_color;
}

vec3 detect_edges(sampler2D tex, vec2 uv, vec2 tex_size) {
    vec2 texel = 1.0 / tex_size;

    // Sobel edge detection
    vec3 tl = texture(tex, uv + vec2(-texel.x, -texel.y)).rgb;
    vec3 tc = texture(tex, uv + vec2(0.0, -texel.y)).rgb;
    vec3 tr = texture(tex, uv + vec2(texel.x, -texel.y)).rgb;
    vec3 ml = texture(tex, uv + vec2(-texel.x, 0.0)).rgb;
    vec3 mr = texture(tex, uv + vec2(texel.x, 0.0)).rgb;
    vec3 bl = texture(tex, uv + vec2(-texel.x, texel.y)).rgb;
    vec3 bc = texture(tex, uv + vec2(0.0, texel.y)).rgb;
    vec3 br = texture(tex, uv + vec2(texel.x, texel.y)).rgb;

    vec3 gx = -tl + tr - 2.0 * ml + 2.0 * mr - bl + br;
    vec3 gy = -tl - 2.0 * tc - tr + bl + 2.0 * bc + br;

    return sqrt(gx * gx + gy * gy);
}

vec3 apply_sharpening(sampler2D tex, vec2 uv, vec2 tex_size) {
    vec2 texel = 1.0 / tex_size;
    vec3 center = texture(tex, uv).rgb;

    vec3 blur = (
        texture(tex, uv + vec2(-texel.x, -texel.y)).rgb +
        texture(tex, uv + vec2(0.0, -texel.y)).rgb +
        texture(tex, uv + vec2(texel.x, -texel.y)).rgb +
        texture(tex, uv + vec2(-texel.x, 0.0)).rgb +
        texture(tex, uv + vec2(texel.x, 0.0)).rgb +
        texture(tex, uv + vec2(-texel.x, texel.y)).rgb +
        texture(tex, uv + vec2(0.0, texel.y)).rgb +
        texture(tex, uv + vec2(texel.x, texel.y)).rgb
    ) / 8.0;

    return center + (center - blur) * sharpness;
}

float get_bayer_matrix(ivec2 pos) {
    // 4x4 Bayer matrix for dithering
    int bayer[16] = int[16](
        0,  8,  2,  10,
        12, 4,  14, 6,
        3,  11, 1,  9,
        15, 7,  13, 5
    );

    int x = pos.x % 4;
    int y = pos.y % 4;
    int index = y * 4 + x;

    return float(bayer[index]) / 15.0;
}

vec3 detect_shadow_transitions(sampler2D tex, vec2 uv, vec2 tex_size) {
    vec2 texel = 1.0 / tex_size;

    // Sample surrounding pixels
    vec3 center = texture(tex, uv).rgb;
    vec3 right = texture(tex, uv + vec2(texel.x, 0.0)).rgb;
    vec3 down = texture(tex, uv + vec2(0.0, texel.y)).rgb;
    vec3 left = texture(tex, uv + vec2(-texel.x, 0.0)).rgb;
    vec3 up = texture(tex, uv + vec2(0.0, -texel.y)).rgb;

    // Calculate luminance for each sample
    float lum_center = dot(center, vec3(0.299, 0.587, 0.114));
    float lum_right = dot(right, vec3(0.299, 0.587, 0.114));
    float lum_down = dot(down, vec3(0.299, 0.587, 0.114));
    float lum_left = dot(left, vec3(0.299, 0.587, 0.114));
    float lum_up = dot(up, vec3(0.299, 0.587, 0.114));

    // Calculate gradient magnitude (how much luminance changes)
    float grad_x = abs(lum_right - lum_left) * 0.5;
    float grad_y = abs(lum_down - lum_up) * 0.5;
    float gradient = sqrt(grad_x * grad_x + grad_y * grad_y);

    return vec3(gradient, lum_center, 0.0);
}

vec3 apply_dithering(vec3 color, vec2 screen_pos, sampler2D tex, vec2 uv, vec2 tex_size) {
    if (dither_amount <= 0.0) return color;

    // Detect shadow/light transitions
    vec3 transition_data = detect_shadow_transitions(tex, uv, tex_size);
    float gradient_strength = transition_data.x;
    float luminance = transition_data.y;

    // Only apply dithering in transition areas
    float transition_factor = smoothstep(0.05, 0.2, gradient_strength * shadow_sensitivity);
    if (transition_factor < 0.01) return color;

    // Get Bayer matrix value for current pixel
    ivec2 pixel_pos = ivec2(floor(screen_pos * dot_size));
    float bayer_value = get_bayer_matrix(pixel_pos);

    // Create threshold based on luminance and user control
    float threshold = dither_threshold + (bayer_value - 0.5) * dither_amount;

    // Determine if this pixel should be a dot
    float is_dot = step(threshold, luminance);

    // Create darker dots in shadow areas, lighter in bright areas
    vec3 dot_color = mix(dither_color.rgb, color * 1.2, luminance);
    vec3 dithered = mix(dot_color, color, is_dot);

    // Blend based on transition strength and user blend control
    float final_blend = transition_factor * dither_blend;
    return mix(color, dithered, final_blend);
}

void fragment() {
    vec2 texture_size = vec2(textureSize(TEXTURE, 0));

    // Apply pixelation
    vec2 pixel_uv = UV;

    if (target_pixel_count < int(texture_size.x)) {
        // Calculate how many source pixels map to one target pixel
        float scale_factor = texture_size.x / float(target_pixel_count);
        vec2 pixel_size = vec2(scale_factor) / texture_size;
        pixel_uv = floor(UV / pixel_size) * pixel_size + pixel_size * 0.5;
    }

    // Get base color
    vec4 tex_color = texture(TEXTURE, pixel_uv);
    vec3 color = tex_color.rgb;

    // Apply sharpening
    if (sharpness > 0.0) {
        color = apply_sharpening(TEXTURE, pixel_uv, texture_size);
    }

    // Apply HSV adjustments
    vec3 hsv = rgb_to_hsv(color);
    hsv.x = fract(hsv.x + hue_shift / 360.0);
    hsv.y *= saturation;
    hsv.z *= value_brightness;
    color = hsv_to_rgb(hsv);

    // Apply contrast and brightness
    color = pow(color, vec3(1.0 / gamma));
    color = (color - 0.5) * contrast + 0.5;
    color += brightness;

    // Apply palette constraint first (before quantization)
    color = apply_palette(color);

    // Quantize colors AFTER all other processing
    if (color_steps < 32) {
        color = quantize_color(color);
    }

    // Apply edge detection for outlines
    if (outline_thickness > 0.0) {
        vec3 edges = detect_edges(TEXTURE, pixel_uv, texture_size);
        float edge_strength_calc = length(edges);

        if (edge_strength_calc > edge_strength) {
            // Improved outline blending with better intensity scaling
            float outline_intensity = clamp(outline_thickness / 10.0, 0.0, 1.0);
            color = mix(color, outline_color.rgb, outline_intensity);
        }
    }

    // Apply dithering (after all other processing)
    // Use pixelated coordinates so dithering appears on the pixelated result
    vec2 screen_pos = pixel_uv * texture_size;
    color = apply_dithering(color, screen_pos, TEXTURE, pixel_uv, texture_size);

    // Clamp final color
    color = clamp(color, 0.0, 1.0);

    COLOR = vec4(color, tex_color.a);
}