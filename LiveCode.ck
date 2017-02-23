Chmusick live => dac;

SinOsc bass;
SndBuf bd; live.file("bd") => bd.read;
SndBuf arpy; live.file("arpy") => arpy.read;
SndBuf battles; live.file("print") => battles.read;

live.every(4) @=> int bdR[];
live.every(4) => live.densify => live.rotate @=> int arpyR[];
([34,0,0,0],2) => live.rotate @=> int bassR[];
[1,0,0,1] @=> int battlesR[];

spork~live.play(bd,bdR);
spork~live.play(arpy,arpyR,1);
spork~live.play(bass,bassR);
spork~live.play(battles,battlesR,1);

for(0 => int i; i < 8; i++){
    live.Dur(120,4) => now;
    live.file("arpy",i+1) => arpy.read;
}
Machine.add(me.dir()+"LiveCode.ck");