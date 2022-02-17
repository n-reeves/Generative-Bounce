SndBuf buffer => LPF lpf => HPF hpf =>  dac;
SndBuf buffer2 => LPF lpf2 => HPF hpf2 => Echo echo2 => dac;
me.dir() + "092_crunchy-analog-bounce.wav" => buffer.read;
me.dir() + "Kisses-92bpm-Ebm-mix.wav" => buffer2.read;

.8 => buffer.gain;
.6 => buffer2.gain;

buffer.samples()/16 => int s;
buffer2.samples()/96 => int t;
s::samp => dur tick;

tick*0 => echo2.delay;

SinOsc sin1 => dac;
.1 => sin1.gain;
[53, 51, 53, 54, 54, 56, 51, 46] @=> int melody1[];
SinOsc sin2 => dac;
.1 => sin2.gain;
[58, 54, 56, 57, 58, 60, 54, 56] @=> int melody2[];
SinOsc sin3 => dac;
.1 => sin3.gain;
[65, 61, 61, 63, 61, 65, 61, 60] @=> int melody3[];
0 => int m;


300 => lpf.freq;
300 => lpf2.freq;

100 => hpf.freq;
100 => hpf2.freq;
1 => lpf.Q;
0 => int x;

for(0 => int i; i < 4; i++) {
    if(m == 8) {
        0 => m;
    }
    for(0 => int j; j <4; j++){
        if(j%2 == 0) {
            Std.mtof(melody1[m]) => sin1.freq;
            Std.mtof(melody2[m]) => sin2.freq;
            Std.mtof(melody3[m]) => sin3.freq;
            m++;
        }

        for( 0 => int k; k < 2; k++) {
            if(k == 1) {
                if(Std.rand2(0,10) < 2) {
                    t * Std.rand2(0,7) => buffer2.pos;
                }
            }
            s * Std.rand2(0,15) => buffer.pos;
            if(buffer2.pos() > 7){
                t * Std.rand2(0,7) => buffer2.pos;
            }
            
            lpf.freq() + 137.5 => lpf.freq;
            lpf2.freq() + 137.5 => lpf2.freq;
          
            tick => now;
        }
    }
}

for (0 => int i; i< 4; i++) {
    if(m == 8) {
        0 => m;
    }
    for(0 => int j; j <4; j++){
        if(j%2 == 0) {
        Std.mtof(melody1[m]) => sin1.freq;
        Std.mtof(melody2[m]) => sin2.freq;
        Std.mtof(melody3[m]) => sin3.freq;
        m++;
    }

        for( 0 => int k; k < 2; k++) {
            if(k == 1) {
                if(Std.rand2(0,10) < 2) {
                    t * Std.rand2(0,7) => buffer2.pos;
                }
            }
            s * Std.rand2(0,15) => buffer.pos;
            if(buffer2.pos() > 7){
                t * Std.rand2(0,7) => buffer2.pos;
            }
            tick => now;
        }
    }
}

for(0 => int i; i < 4; i++) {
        
        if(m == 8) {
            0 => m;
        }
        
        if(i == 0) {
           tick/8 => echo2.delay; 
        }
        
        if(i == 2) {
           tick => echo2.delay; 
        }
        /*
        if(i == 4) {
           tick/4 => echo2.delay; 
        }
        
        if(i == 6) {
           tick => echo2.delay; 
        }
        */
        for(0 => int j; j <4; j++){
            if(j%2 == 0) {
                Std.mtof(melody1[m]) => sin1.freq;
                Std.mtof(melody2[m]) => sin2.freq;
                Std.mtof(melody3[m]) => sin3.freq;
                m++;
                
                
        }

            for( 0 => int k; k < 2; k++) {
                if(k == 1) {
                    if(Std.rand2(0,10) < 2) {
                        t * Std.rand2(0,7) => buffer2.pos;
                    }
                }
                
                s * Std.rand2(0,15) => buffer.pos;
                if(buffer2.pos() > 7){
                    t * Std.rand2(0,7) => buffer2.pos;
                }
                
                hpf2.freq() + 10 => hpf2.freq;

                tick => now;
            }
        }    
}
0 => buffer.gain;
0 => m;

tick/8 => echo2.delay;

for (0 => int i; i<32; i++){
    if (i%4 ==0){
        Std.mtof(melody1[m]) => sin1.freq;
        Std.mtof(melody2[m]) => sin2.freq;
        Std.mtof(melody3[m]) => sin3.freq;
        m++;
    }
    t*(8-(m+1)) => buffer2.pos;
    tick => now;
}

0 => sin1.gain;
0 => sin2.gain;
0 => sin3.gain;

for (0 => int i; i<15; i++){
   tick => now; 
}
0 => buffer2.gain;
