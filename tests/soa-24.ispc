
struct Point { float x, y, z; };

struct Foo {
    float<3> vec;
    int8 z;
};

export uniform int width() { return programCount; }

export void f_fu(uniform float RET[], uniform float aFOO[], uniform float b) {
    float a = aFOO[programIndex]; 

    soa<8> Foo * uniform pts = uniform new soa<8> Foo[4];
//CO    uniform Foo pts[32];
    foreach (i = 0 ... 32) {
        pts[i].vec.x = b*i;
        pts[i].vec.y = -b*i;
        pts[i].vec.z = 2*b*i;
        pts[i].z = i;
    }

    pts[programIndex+2].vec.z *= -1;    
    float<3> vl = pts[programIndex].vec;
    RET[programIndex] = vl.z;
}

export void result(uniform float RET[]) {
    RET[programIndex] = 10 * programIndex;
    if (programIndex >= 2)
        RET[programIndex] *= -1;
}
