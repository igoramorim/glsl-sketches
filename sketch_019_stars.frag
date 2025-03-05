#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

#define NUM_LAYERS 8.

mat2 rot(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
}

// random number between 0 and 1
float hash21(vec2 p) {
    p = fract(p*vec2(123.35, 543.32));
    p += dot(p, p+45.65);
    return fract(p.x*p.y);
}

float star(vec2 uv, float flare) {
    float d = length(uv);
    float m = .05/d;
    float rays = max(0., 1.-abs(uv.x*uv.y*500.));
    m += rays*flare;
    // rotate 45 dregrees
    uv *= rot(3.1415/4.);
    rays = max(0., 1.-abs(uv.x*uv.y*500.));
    m += rays*.3*flare;
    m*= smoothstep(1., .2, d);
    
    return m;
}

vec3 starLayer(vec2 uv) {
    vec3 col = vec3(0.0);
    
    vec2 gv = fract(uv)-.5;
    // every box id
    vec2 id = floor(uv);
    
    // consider the glow of the neighbor cells
    for (float y=-1.; y<=1.; y++) {
        for (float x=-1.; x<=1.; x++) {
            vec2 offs = vec2(x, y);
            float n = hash21(id+offs);
            float size = fract(n*525.65);
            float star = star(gv-offs-vec2(n, fract(n*34.))+.5, smoothstep(.9, 1., size)*.8);
            vec3 color = sin(vec3(.2, .6, .1)*fract(n*2954.32)*156.2)*.5+.5;
            color = color*vec3(1., .5, 1.+size);
            star *= sin(u_time*2.+n*8.532)*.3+1.;
            col += star*size*color;
        }    
    }
    
    return col;
}

void main(void)
{
    // -.5 to .5 and
    vec2 uv = (gl_FragCoord.xy -.5 * u_resolution.xy) / u_resolution.y;
    vec2 mouse = (u_mouse.xy-u_resolution.xy*.5) / u_resolution.y;
    float t = u_time*.03;
    uv += mouse;
    uv *= rot(t);
    vec3 col = vec3(0.);
    
    for(float i=0.; i<1.; i+=1./NUM_LAYERS) {
        float depth = fract(i+t);
        float scale = mix(20., .5, depth);
        float fade = depth*smoothstep(1., .9, depth);
        col += starLayer(uv*scale+i*634.2)*fade;
    }
    
    // if(gv.x > .49 || gv.y > .49) col.r=1.;
    
    gl_FragColor = vec4(col, 1.0);
}