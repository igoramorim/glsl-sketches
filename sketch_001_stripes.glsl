#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rotate(vec2 p, float angle) {
    vec2 direction = vec2(cos(angle), sin(angle));
    return cos(dot(p, direction));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    vec2 p = (st - 0.5) * 50.0;

    float b = 0.;
    b += rotate(p, 0.);
    b += rotate(p, u_time);
    b += rotate(p, 1.);
    b += rotate(st, abs(sin(u_time+p.x) * 5.));

    // for (float i = 1.; i <= 11.; i++) {
    //     b += rotate(p, u_time/i);
    // }

    b = 1.-pow(b, abs(sin(u_time)));
    // b += rotate(p, abs(sin(u_time+p.y)));
    // b += rotate(p, abs(p.x + sin(u_time) * 10.));
    // b += rotate(p, u_time+abs(sin(u_time)));

    // pct.g = abs(cos(sin(u_time + 2. * st.x) * 5. * st.y + u_time));

    // b = abs(mod(b, 2.) -1.);
    // b += rotate(p, abs(cos(sin(u_time + 2. * st.x) * 5. * st.y + u_time)));
    // b += abs(sin(cos(st.y + u_time) * 10. * st.x + u_time));


    gl_FragColor.rgb = vec3(b);
    gl_FragColor.a = 1.0;
}