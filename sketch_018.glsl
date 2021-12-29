#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float time,t, g=0.;
vec2 sc;

mat2 rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

float box(vec3 p, vec3 s) {
  p = abs(p)-s;
  return max(max(p.x, p.y), p.z);
}

float cap(vec3 p, float h, float r) {
  p.y -= clamp(p.y, 0., h);
  return length(p)-r;
}

float sph(vec3 p, float r) {
    return length(p)-r;
}

vec2 geo(vec3 p) {
  //p.x += sin(p.z*.1)*4.;
    
  // id 3
  vec2 h,t = vec2(box(p, vec3(30., .2, .2)), 3.);
  t.x = min(box(abs(p)-vec3(3., 0., 0.), vec3(.1, .1, 1.)), t.x);
  // id 1
  h = vec2(box(p, vec3(30., .05, .3)), 1.);
  //h.x = min(box(p, vec3(15., .25, .1)), h.x);
  t = (t.x<h.x) ? t:h;
  // id 2
  h = vec2(sph(abs(p)-vec3(3., 0., 1.), .3), 2.);
  t = (t.x<h.x) ? t:h;
  
  //t.x *= .5; // helps remove artifacts
  return t;
}

vec2 mp(vec3 p) {
  p.yz *= rot(sin(p.x*.1)*.2+time);
  p.x = mod(p.x+time*10., 10.)-5.;
  vec3 np = p;
  float s = sin(p.z*.1+time*2.-.5)*.1;
  
  for(int i=0; i<6; i++) {
    //np = abs(np)-vec3(4.-4.*s, 0., max(4.*s, .6));
    //np = abs(np)-vec3(4.-4.*s, 0., 1.);
    //np.xy *= rot(.4+s);
    //np.xz *= rot(.3+s);
    //np.yz *= rot(sin(p.z*.2-time)*.1);
  }
  vec2 h,t = geo(np);
  
  return t;
}

vec2 tr(vec3 ro, vec3 rd) {
  vec2 h,t = vec2(.1);
  for(int i = 0; i < 128; i++) {
    h = mp(ro+rd*t.x);
    // hit something
    if(h.x < .0001 || t.x > 50.) {
      // h.y (material id) above 10 is transparency
      if(h.y < 10. || t.x > 50.) break;
      t.x += .3;
      continue;
    }
    t.x += h.x;
    t.y = h.y;
  }
  if(t.x > 50.) t.x = 0.;
  return t;
}

void main(void)
{
   vec2 uv = vec2(gl_FragCoord.x / u_resolution.x, gl_FragCoord.y / u_resolution.y);
    uv -= 0.5;
    uv /= vec2(u_resolution.y / u_resolution.x, 1);
    time = mod(u_time*.5, 30.);
    
    // setup camera
    //vec3 ro = vec3(2.5, 0., -50.*clamp(sin(time), -.7, .7)),
    //vec3 ro = vec3(sin(time)*5., 10., -10.),
    //vec3 ro = vec3(10., 3., -20.),
    vec3 ro = vec3(2.5, 5., -10),
         cw = normalize(vec3(0.) - ro),
         cu = normalize(cross(cw, vec3(0., 1., 0.))),
         cv = normalize(cross(cu, cw)),
         rd = mat3(cu, cv, cw) * normalize(vec3(uv, .5)),
    // setup default color, fog and light direction
         col, fog, ld = normalize(vec3(0,0.5,-0.5));
         
    col=fog=vec3(.01, .01, .02)*(1.-(length(uv)-.1));
      
    // render the scene
    sc = tr(ro, rd);
    t = sc.x;
  
    // hit something
    if(t > 0.) {
        vec2 e = vec2(.00035, -.00035);
        vec3 po = ro+rd*t,
             // normals
             no = normalize(e.xyy*mp(po+e.xyy).x +
                            e.yyx*mp(po+e.yyx).x +
                            e.yxy*mp(po+e.yxy).x +
                            e.xxx*mp(po+e.xxx).x),
             al = vec3(.2, .2, .2);

        if(sc.y < 1.5) {
          al = vec3(.9, .9, .9);
        } else if(sc.y < 2.5) {
            al = vec3(.9, .4, .1);
        } else if(sc.y < 3.5) {
            al = vec3(.2, .4, .9);
        } else if(sc.y > 5.) al = vec3(0.);
        
        float dif = max(0., dot(no, ld));

        col = dif*al;
    }
    // glow
    //col += g*.03;

    // Output to screen
    gl_FragColor = vec4(pow(col, vec3(.45)) ,1.);
}