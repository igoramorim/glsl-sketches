#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265359

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

float pattern(vec2 st, float r) {
    return circ(st+vec2(0., -.5), r)+
           circ(st+vec2(0., .5), r)+
           circ(st+vec2(-.5, 0.), r)+
           circ(st+vec2(.5, 0.), r);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    vec3 color = vec3(0.);

    vec2 grid1 = tile(st+vec2(cos(u_time), sin(u_time))*.01, 8.);
    vec3 col11 = vec3(0.0941, 0.3725, 0.6);
    vec3 col12 = vec3(0.9451, 0.5451, 0.2196);
    color += mix(col11, col12, pattern(grid1, .15)-pattern(grid1+vec2(sin(u_time), cos(u_time))*.02, .03));

    vec2 grid2 = tile(st+vec2(sin(u_time), cos(u_time))*.015, 3.);
    vec3 col21 = vec3(0.1373, 0.0549, 0.2275);
    color = mix(color, col21, pattern(grid2, .07))+pattern(grid2+vec2(cos(u_time), sin(u_time))*.02, .01);

    if(grid1.x>.49 || grid1.y>.49) color = vec3(0., 1., 0.);
    if(grid2.x>.49 || grid2.y>.49) color = vec3(1., 0., 0.);

	gl_FragColor = vec4(color, 1.);
}
