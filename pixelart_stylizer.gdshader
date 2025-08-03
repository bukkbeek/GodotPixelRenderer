shader_type spatial;
render_mode unshaded;

// Screen-space textures
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D NORMAL_TEXTURE : hint_normal_roughness_texture, filter_nearest;

// Outline effect controls
uniform bool shadows_enabled = true;       // Enable depth-based outlines
uniform bool highlights_enabled = true;    // Enable normal-based outlines
uniform float shadow_strength : hint_range(0.0, 1.0, 0.01) = 0.4;    // Darkness of depth outlines
uniform float highlight_strength : hint_range(0.0, 1.0, 0.01) = 0.1; // Intensity of normal outlines
uniform vec3 highlight_color : source_color = vec3(1.);              // Color for normal outlines
uniform vec3 shadow_color : source_color = vec3(0.0);                // Color for depth outlines
uniform float outline_size : hint_range(0.0, 100.0, 0.1) = 1.0;      // Controls outline thickness

varying mat4 model_view_matrix;

// Converts screen UV to view-space depth
float getDepth(vec2 screen_uv, sampler2D depth_texture, mat4 inv_projection_matrix){
    float raw_depth = texture(depth_texture, screen_uv)[0];
    vec3 ndc = vec3(screen_uv * 2.0 - 1.0, raw_depth);
    vec4 view_space = inv_projection_matrix * vec4(ndc, 1.0);
    view_space.xyz /= view_space.w;
    return -view_space.z;
}

// Reconstructs world position from depth
vec3 getPos(float depth, mat4 mvm, mat4 ipm, vec2 suv, mat4 wm, mat4 icm){
    vec4 pos = inverse(mvm) * ipm * vec4((suv * 2.0 - 1.0), depth * 2.0 - 1.0, 1.0);
    pos.xyz /= (pos.w+0.0001*(1.-abs(sign(pos.w)))); // Safe division
    return (pos*icm).xyz+wm[3].xyz;
}

// Detects edges based on normal changes
float normalIndicator(vec3 normalEdgeBias, vec3 baseNormal, vec3 newNormal, float depth_diff){
    float normalDiff = dot(baseNormal - newNormal, normalEdgeBias);
    float normalIndicator = clamp(smoothstep(-.01, .01, normalDiff), 0.0, 1.0);
    float depthIndicator = clamp(sign(depth_diff * .25 + .0025), 0.0, 1.0);
    return (1.0 - dot(baseNormal, newNormal)) * depthIndicator * normalIndicator;
}

void vertex(){
    // Construct model-view matrix
    model_view_matrix = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
}

void fragment() {
    // Calculate pixel offset based on outline size
    vec2 e = vec2(1./VIEWPORT_SIZE.xy) * outline_size;

    // Sampling directions (up, right, down, left)
    vec2 offsets[4];
    offsets[0] = vec2(0.0, -1.0); // Up
    offsets[1] = vec2(1.0, 0.0);  // Right
    offsets[2] = vec2(0.0, 1.0);  // Down
    offsets[3] = vec2(-1.0, 0.0); // Left

    // Depth-based edge detection (shadows)
    float depth_diff = 0.0;
    float neg_depth_diff = 0.5; // Initial bias
    if (shadows_enabled) {
        float depth = getDepth(SCREEN_UV, DEPTH_TEXTURE, INV_PROJECTION_MATRIX);

        // Sample neighboring pixels
        for (int i = 0; i < 4; i++) {
            vec2 offset = offsets[i] * e;
            float neighbor_depth = getDepth(SCREEN_UV + offset, DEPTH_TEXTURE, INV_PROJECTION_MATRIX);
            depth_diff += clamp(neighbor_depth - depth, 0., 1.);
            neg_depth_diff += depth - neighbor_depth;
        }

        // Normalize and threshold depth differences
        neg_depth_diff = clamp(neg_depth_diff, 0., 1.);
        neg_depth_diff = step(0.5, neg_depth_diff); // Binary threshold
        depth_diff = smoothstep(0.2, 0.3, depth_diff); // Smooth transition
    }

    // Normal-based edge detection (highlights)
    float normal_diff = 0.0;
    if (highlights_enabled) {
        vec3 normal = texture(NORMAL_TEXTURE, SCREEN_UV).rgb * 2.0 - 1.0;
        vec3 normal_edge_bias = vec3(1.0); // Uniform bias

        // Sample neighboring normals
        for (int i = 0; i < 4; i++) {
            vec2 offset = offsets[i] * e;
            vec3 neighbor_normal = texture(NORMAL_TEXTURE, SCREEN_UV + offset).rgb * 2.0 - 1.0;
            normal_diff += normalIndicator(normal_edge_bias, normal, neighbor_normal, depth_diff);
        }

        // Normalize normal differences
        normal_diff = smoothstep(0.2, 0.8, normal_diff);
        normal_diff = clamp(normal_diff - neg_depth_diff, 0., 1.); // Remove overlap with shadows
    }

    // Final color composition
    vec3 original_color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
    vec3 final = original_color;

    // Apply highlights if enabled
    if (highlights_enabled) {
        vec3 highlight = mix(original_color, highlight_color, highlight_strength);
        final = mix(final, highlight, normal_diff);
    }

    // Apply shadows if enabled
    if (shadows_enabled) {
        vec3 shadow = mix(original_color, shadow_color, shadow_strength);
        final = mix(final, shadow, depth_diff);
    }

    // Output results
    ALBEDO = final;
    ALPHA = clamp((depth_diff * float(shadows_enabled) + normal_diff * float(highlights_enabled)) * 5.0, 0.0, 1.0);
}