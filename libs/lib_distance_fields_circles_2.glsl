// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


// float myCircle(vec2 st, vec2 pos, float r) {
//     float pct = 0.0;
//     pct = distance(st, pos);
//     pct = step(r, pct);
//     return pct;
// }

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution;
    float pct = 0.0;

    // pct = distance(st,vec2(0.5));
    // pct = distance(st, vec2(0.4)) + distance(st,vec2(0.6));
    // pct = distance(st,vec2(0.2)) * distance(st,vec2(0.6));
    // pct = min(distance(st,vec2(0.2)),distance(st,vec2(0.6)));
    float x = abs(cos(u_time));
    float y = abs(sin(u_time));
    // pct = max(distance(st,vec2(x, y)),distance(st,vec2(0.5)));
    pct = pow(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
    
    // comment to see the gradient distance field
    pct = step(.5, pct);
    vec3 color = vec3(pct);

	gl_FragColor = vec4( color, 1.0 );
}
