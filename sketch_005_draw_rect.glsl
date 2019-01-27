#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float gradCircle(float start, float end, vec2 _st) {
    vec2 bl = smoothstep(start, end, _st);
    vec2 tr = smoothstep(start, end, 1.-_st);
    float pct = bl.x * bl.y * tr.x * tr.y;
    return pct;
}

float rect(float thick, vec2 _st) {
    vec2 bl = step(vec2(thick), _st);
    vec2 tr = step(vec2(thick), 1.-_st);
    float pct = bl.x * bl.y * tr.x * tr.y;
    return pct;
}

vec3 drawRect(in vec2 st,
              in vec2 center,
              in float w,
              in float h,
              in float thickness) {
    
    vec3 color = vec3(0.0);
    
    float halfWidth = w * .5;
    float halfHeight = h * .5;
    float halfThickness = thickness * .5;
    
    vec2 bottomLeft = vec2(center.x - halfWidth, center.y - halfHeight);
    vec2 topRight = vec2(center.x + halfWidth, center.y + halfHeight);
    
    vec2 stroke = vec2(0.0);
    stroke += step(bottomLeft - halfThickness, st) * (1.0 - step(bottomLeft + halfThickness, st));
    stroke += step(topRight - halfThickness, st) * (1.0 - step(topRight + halfThickness, st));
    vec2 strokeLimit = step(bottomLeft - halfThickness, st) * (1.0 - step(topRight + halfThickness, st));
    stroke *= strokeLimit.x * strokeLimit.y;
    
    color = mix(color, vec3(1.), min(stroke.x + stroke.y, 1.));
    return color;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
    
    // botton left
    // vec2 bl = step(vec2(0.03), st);
    // float pct = bl.x * bl.y;

    // top right
    // vec2 tr = step(vec2(0.03), 1.-st);
    // vec2 tr = smoothstep(0., .7, 1.-st);
    // pct *= tr.x * tr.y;
    
    // float pct = gradCircle(0., 0.7, st);
    // float pct = rect(0.03, st);
    
    color = drawRect(st, vec2(0.5,0.5), .3, .2, .02);
    color += drawRect(st, vec2(0.2,0.2), .1, .3, .02);
    
    // color = vec3(pct);

    gl_FragColor = vec4(color, 1.0);
}