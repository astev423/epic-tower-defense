shader_type canvas_item;
render_mode unshaded;

uniform vec4 color_a : source_color = vec4(0.1098039, 0.3529412, 0.2666667, 1.0); // #1C5A44
uniform vec4 color_b : source_color = vec4(0.1843137, 0.6823529, 0.4823529, 1.0); // #2FAE7B
uniform float gradient_angle = 0.9; // radians

uniform float vignette_strength = 0.38; // lower = lighter overall
uniform float vignette_softness = 0.48;

uniform float noise_amount = 0.02;
uniform float noise_scale = 900.0;

uniform vec2 blob1_pos = vec2(0.35, 0.35);
uniform vec4 blob1_color : source_color = vec4(0.3411765, 1.0, 0.7803922, 1.0); // #57FFC7
uniform float blob1_radius = 0.45;
uniform float blob1_intensity = 0.20;

uniform vec2 blob2_pos = vec2(0.75, 0.25);
uniform vec4 blob2_color : source_color = vec4(0.7137255, 1.0, 0.4156863, 1.0); // #B6FF6A
uniform float blob2_radius = 0.55;
uniform float blob2_intensity = 0.13;

uniform vec2 blob3_pos = vec2(0.70, 0.75);
uniform vec4 blob3_color : source_color = vec4(0.1764706, 1.0, 0.6039216, 1.0); // #2DFF9A
uniform float blob3_radius = 0.65;
uniform float blob3_intensity = 0.09;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453123);
}

float soft_blob(vec2 uv, vec2 center, float radius) {
    float d = length(uv - center);
    return exp(-pow(d / max(radius, 0.0001), 2.0) * 4.0);
}

void fragment() {
    vec2 uv = SCREEN_UV;

    vec2 dir = vec2(cos(gradient_angle), sin(gradient_angle));
    float t = dot(uv - vec2(0.5), dir) + 0.5;
    t = clamp(t, 0.0, 1.0);
    vec3 col = mix(color_a.rgb, color_b.rgb, t);

    vec2 drift = vec2(sin(TIME * 0.12), cos(TIME * 0.10)) * 0.015;

    float b1 = soft_blob(uv, blob1_pos + drift, blob1_radius);
    float b2 = soft_blob(uv, blob2_pos + drift * 0.7, blob2_radius);
    float b3 = soft_blob(uv, blob3_pos - drift * 0.5, blob3_radius);

    col += blob1_color.rgb * b1 * blob1_intensity;
    col += blob2_color.rgb * b2 * blob2_intensity;
    col += blob3_color.rgb * b3 * blob3_intensity;

    float aspect = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
    vec2 p = (uv - vec2(0.5)) * vec2(aspect, 1.0);
    float dist = length(p);
    float vig = smoothstep(0.55, 0.55 + max(vignette_softness, 0.001), dist);
    col *= (1.0 - vig * vignette_strength);

    float n = hash(uv * noise_scale) - 0.5;
    col += n * noise_amount;

    COLOR = vec4(col, 1.0);
}

