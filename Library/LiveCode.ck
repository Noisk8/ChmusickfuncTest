Chmusick live => JCRev rev => Gain gate => dac;
Notes notes;

SinOsc bass;
TriOsc tri;
TheCooker synth => dac;

live.file("kick",5) => Buffer.d1.read;
live.file("hihat",14) => Buffer.d2.read;
live.file("xmas",1) => Buffer.d3.read;
live.file("house",2) => Buffer.d4.read;
live.file("claps",1) => Buffer.d5.read;

2 => live.CYCLES;
4 => live.MEASURE;
0.025 => rev.mix;
130 => live.TEMPO;
0.5 => gate.gain;
0.5 => tri.gain;

[1,0,0,0,1,0,0,0] @=> int bdR[];
live.every(1)  @=> int hhR[];
[45,0,0,45,0,45,0,0] => live.rotate @=> int bassR[];
[0,0,0,0,0,0,1,0] => live.densify @=> int jungle[];
[1,0,0] @=> int house[];

/*spork~live.play(Buffer.d1,bdR,0);*/
/*spork~live.play(Buffer.d2,hhR,1);*/
/*spork~live.play(bass,bassR,0);*/
/*spork~live.play(Buffer.d5,jungle,0);*/
/*spork~live.play(tri,live.subArray(live.transpose(notes.modes(1),48),[1,-1,-1,-1,-1,6,-1,-1,-1,-1]),0);*/
/*spork~live.play(Buffer.d3,jungle,0);*/
/*spork~synth.sound(8,live.subArray(live.transpose(notes.modes(5),45),[1,-1,-1,-1,-1,6,-1,-1,-1,-1]));*/
/*spork~live.play(Buffer.d4,house,0);*/


while(true){
    for(0 => int i; i < 8; i++){
        live.Dur(live.TEMPO,live.MEASURE) => now;
        //live.file("arpy",i+1) => Buffer.d3.read;
        if(STATIC.BEATS % 8 == 0){
            for(0 => int i; i < bassR.size(); i++){
                if(bassR[i] != 0){
                    //bassR[i] + 2 => bassR[i];
                }
            }
        }
    }
}
