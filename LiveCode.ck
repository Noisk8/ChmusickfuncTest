Chmusick live => dac;

SinOsc bass;
SndBuf bd; live.file("bd") => bd.read;
SndBuf hh; live.file("hh",1) => hh.read;
SndBuf arpy; live.file("arpy") => arpy.read;
SndBuf battles; live.file("print") => battles.read;

live.every(2) @=> int bdR[];
(live.every(2),1) => live.rotate @=> int hhR[];
live.every(4) => live.densify => live.rotate @=> int arpyR[];
([34,0,0,0],1) => live.rotate @=> int bassR[];
[1,0,0,0] @=> int battlesR[];

spork~live.play(bd,bdR,1);
spork~live.play(hh,hhR,1);
spork~live.play(arpy,arpyR,0);
spork~live.play(bass,bassR,0);
spork~live.play(battles,battlesR,2);

for(0 => int i; i < 8; i++){
    live.Dur(120,4) => now;
    live.file("arpy",i+1) => arpy.read;
}
Machine.add(me.dir()+"LiveCode.ck");