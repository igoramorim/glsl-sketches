#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.14159265359

mat2 rot2D(float a) {
    return mat2(cos(a), -sin(a),
                sin(a), cos(a));
}

// create tiles with 0,0 in the middle
vec2 tile(vec2 uv, float n) {
    uv *= n;
    return fract(uv)-.5;
}

float circle(vec2 uv, float r) {
    float d = length(uv);
    return smoothstep(r+(r*.01), r-(r*.01), d);
}

void main() {
    // -1 to 1
    vec2 uv = (gl_FragCoord.xy -.5 * u_resolution.xy) / u_resolution.y;
    
    float t = u_time * 2.;
    // uv = rot2D(sin(t * .2) * PI) * uv;

    // zoom out
    uv *= 3.;

    vec2 tileUv = tile(uv, 5.);
    // gives each tile an id
    vec2 tileId = floor(uv * 5.);

    float circ = 0.;

    /*
    | -1, -1 | 0, -1 | 1, -1 |
    | -1,  0 | 0,  0 | 1,  0 |
    | -1,  1 | 0,  1 | 1,  1 |
    */
    for (float y = -1.; y <= 1.; y++) {
        for (float x = -1.; x <= 1.; x++) {
            vec2 offset = vec2(x, y);

            // distance from screen to the tile
            float distToTile = length(tileId + offset) * 30.;

            float r = mix(.3, 1.5, sin(t + distToTile) * .5 + .5);

            circ += circle(tileUv - offset, r);
        }
    }

    vec3 col = vec3(uv.x);
    // col.rg = tileUv;
    col += mod(circ, 2.);

	gl_FragColor = vec4(col, 1.);
}