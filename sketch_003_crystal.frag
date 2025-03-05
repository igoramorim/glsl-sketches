// Code based from http://pixelshaders.com/
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(float p) {
  return fract(sin(p)*10000.);
}

float noise(vec2 p) {
  return random(p.x + p.y*10000.);
}

float wave(vec2 p, float angle) {
    vec2 direction = vec2(cos(angle), sin(angle));
    return cos(dot(p, direction));
}

float wrap(float x) {
    return abs(mod(x, 2.) -1.);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    vec2 p = (st - 0.5) * 50.;
    
    float brigthess = 0.;
    for (float i = 1.; i <= 11.; i++) {
        brigthess += wave(p, u_time / i);
    }
    
    brigthess = wrap(brigthess);

    // Output to screen
    gl_FragColor.rgb = vec3(brigthess);
    gl_FragColor.a = 1.;
}
