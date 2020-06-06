#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265359

float rand(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

mat2 rot2D(float a){
    return mat2(cos(a),-sin(a),
                sin(a),cos(a));
}

vec2 tile(vec2 st, float n) {
    st *= n;
    // st.x += step(1., mod(st.y, 2.0))*0.5; // offset
    // st.y += step(1., mod(st.x, 2.0))*0.5; // offset
    return fract(st)-.5;
}

float circ(vec2 st, float r) {
    // return 1.0-length(st)-r;
    return 1.-smoothstep(r-(r*.01),
                         r+(r*.01),
                         dot(st,st)*4.);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    vec3 color = vec3(0.);

    st = tile(st, 5.);

    float r = 1.; //clamp(sin(u_time)*0.5+0.5, 0.5, 0.55);
    // st = rot2D(clamp(sin(u_time), .0, .53))*st;
    // st = rot2D(clamp(sin(u_time), -.53, .0))*st;
    st = rot2D(sin(u_time*.5)*PI*.5)*st;
    color = vec3(circ(st+vec2(.5, -.5), r));
    color += vec3(circ(st+vec2(-.5, .5), r));

    color *= vec3(0.1, .1, .9);

    // color = vec3(st, 0.0);

	gl_FragColor = vec4(color, 1.);
}
