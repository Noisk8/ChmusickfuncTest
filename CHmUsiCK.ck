//
// Chmusick.ck
// CHmUsiCK
// Created in 2014 by Esteban Betancur
//
// Medellín - Colombia
//
// -One File- 25/01/2017

public class Chmusick extends Chubgraph
//every class that uses CHmUsiCK members must extend this class
{        
    Gain MasterChmusick => Dyno Processor => outlet;
    
    120 => static float TEMPO; // Change this to the BPM you want to CHmUsiCK!
    convert(TEMPO) => static dur DTEMPO;
    
    4 => int OverallDivision;
    
    4 => static int CYCLES;
    4 => static int MEASURE; 
    
    // variables for loop 
    0 => static int BEATS;
    0 => static int MEASURES;
    0 => static int PHRASES;
    8 => static int STEP;
    
    // drum array for save
    [[[1,0,1,0,1,0,1,0],[0,0,0,0,1,0,0,0],[0,1,0,1,0,1,0,1]]] @=> int ArrayDrum[][][];
    
    // favorite array drum
    [[[1,0],[0,1]], 
    [[1,0,0,0,1,1,0,0],[0,0,1,0,0,0,1,0],[1,1,1,1,1,1,1,1]],
    [[1,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0],[0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0],[1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1]],
    [[1,1,1,1],[0,0,1,0],[1,1,1,1]], 
    [[0,0,1,0],[0,0,1,0],[1,1,1,1]],
    [[1,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1],[0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0],[1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]],
    [[1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0],[0,1,0,1,0,0,0,0,0,1,0,0,1,0,0,0],[1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]], 
    [[1,0,0,0,0,0,0,0],[0,1,0,1,0,1,0,1],[0,0,1,0,0,0,1,0]],
    [[1,0,1,0],[0,0,1,0],[0,1,0,1]],
    [[1,1,1,1,1,1,1,1],[0,0,0,0,1,0,0,0],[1,0,1,0,1,0,1,0]], 
    [[1,1,0,0],[0,0,1,0],[0,0,0,1]],
    [[1,0,0,1,0,0,1,0],[1,1,1,1,1,1,1,1],[1,0,0,0,0,0,0,0]]] @=> int FavoriteArrayDrum[][][];
    
    // melody array for save
    [[60,62,0,63,65],[62,0,61,62,0,61,62]] @=> int MelodyArray[][];
    
    5001 => static int PORT;
    "127.0.0.1" => string HOST;
    
    1 => static float MASTER;
    
    MASTER => MasterChmusick.gain;
    
    public string host(string Host) {
        Host => HOST;
        return HOST;
    }
    public string host() {
        return HOST;
    }
    public static int port(int Port) {
        Port => PORT;
        return PORT;
    }
    public static int port() {
        return PORT;
    }
    public static float tempo(float t)
    {
        t => TEMPO;
        return TEMPO;
    }
    public float tempoD(dur t)
    {
        convertD(t) => TEMPO;
        return TEMPO;
    }
    public static float tempo()
    {
        return TEMPO;
    }
    public int overallDivision(int div)
    {
        div  => OverallDivision;
        return OverallDivision;
    }
    public int overallDivision()
    {
        return OverallDivision;
    }
    public static int measure(int m)
    {
        m => MEASURE;
        return MEASURE;
    }
    public static int measure()
    {
        return MEASURE;
    }
    public static int cycles(int c)
    {
        c => CYCLES;
        return CYCLES;
    }
    public static int cycles()
    {
        return CYCLES;
    }
    public static float master(float Mgain)
    {
        Mgain => MASTER;
        return MASTER;
    }
    public float master()
    {
        return MasterChmusick.gain();
    }
    public void limit()
    {
        Processor.limit();
    }
    public void compress()
    {
        Processor.compress();
    }
    public void expand()
    {
        Processor.expand();
    }
    public void gate()
    {
        Processor.gate();
    }
    public void duck()
    {
        Processor.duck();
    }
    public dur fadeIn(dur d)
    {
        0 => MasterChmusick.gain;
        
        while(MasterChmusick.gain() <= 1)
        {
            MasterChmusick.gain() + 0.01 => MasterChmusick.gain;
            (d/100) => now;
        }
        return d;
    }
    public dur fadeOut(dur d)
    {
        MasterChmusick.gain() => MasterChmusick.gain;
        (MasterChmusick.gain()*100) => float div;
        
        while(MasterChmusick.gain() >= 0)
        {
            MasterChmusick.gain() - 0.01 => MasterChmusick.gain;
            (d/div) => now;
        }
        0 => MasterChmusick.gain;
        return d;
    }
    public float accelerate(float limit)
    {
        if(TEMPO < limit)
        {
            while(TEMPO < limit)
            {
                TEMPO + 0.1 => TEMPO;
                convert(TEMPO) => now;
            }
        }
        else
        { 
            while(TEMPO > limit)
            {
                TEMPO - 0.1 => TEMPO;
                convert(TEMPO) => now;
            }
        }
        return limit;
    }
    public int[] melodies(int pos)
    {
        return MelodyArray[pos];
    }
    public float[] stress(int capacity, int positions[])
    // randomly fills an array with 0 to 1 float
    {
        float toReturn[capacity];
        
        for(0 => int i; i < toReturn.cap(); i++)
        {
            0.4 => toReturn[i];
        }
        for(0 => int i; i < positions.cap(); i++)
        {
            1.0 => toReturn[positions[i]];
        }
        return toReturn;
    }
    public int[] rand(int capacity)
    // randomly fills an array with ones
    {
        int random[capacity];
        
        for(0 => int i; i < random.cap(); i ++)
        {
            Math.random2(0,1) => random[i];
        }
        return random;
    }
    public int[] subArray(int pattern[], int toCut[])
    // cuts an array pattern 
    // Thanx to Santiago Beta
    {
        toCut.size() => int newsize;
        int sub[newsize];
        
        for(0 => int i; i < newsize; i++)
        {
            if(toCut[i] < pattern.size() && toCut[i] >= 0) {
                pattern[toCut[i]] => sub[i];
            }
            else {
                0 => sub[i];
            }
        }
        return sub;
    }
    public int[] trunc(int pattern[], float howmany)
    // truncates an array pattern by howmany
    {
        (pattern.size() * howmany)$int => int newsize;
        int truncated[newsize];
        
        for(0 => int i; i < newsize; i++)
        {
            pattern[i] => truncated[i];
        }
        return truncated;
    }
    public int[] trunc(int pattern[], int from, int to)
    // cuts an array from - to // idea: Santiago Beta
    {
        if(from >= 0 && to <= pattern.cap() && from < to)
        {
            int truncated[0];
            
            for(from => int i; i < to; i++)
            {
                truncated << pattern[i];
            }
            return truncated;
        }
        else
        {
            <<< "something is wrong, check trunc() parameters" >>>;
            return pattern;
        }
    }
    public int[] reverse(int pattern[])
    // reverse an array
    {
        int reversed[0];
        
        for((pattern.cap()-1) => int i; i >= 0 ; i - 1 => i)
        {
            reversed << pattern[i];
        }
        return reversed;
    }
    public int[] densify(int pattern[])
    // ramdomly add ones to an int array
    {
        int notes[0];
        
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] != 0) 
            {
                notes << pattern[i];
            }
        }
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] == 0 && maybe)
            {
                notes[Math.random2(0, (notes.cap() - 1))] => pattern[i];
            } 
        }
        return pattern;
    }
    public int[] degrade(int pattern[])
    // randomly removes non zero events of an int array
    {
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] != 0 && maybe)
            {
                0 => pattern[i];
            }
        }
        return pattern;
    }
    public int[] every(int parameter)
    // fills an array of parameter size with ones
    {
        int everyArray[parameter];
        
        if(parameter == 0)
        {
            everyArray << 0;
            return everyArray;
        }
        else
        {
            1 => everyArray[0];
            
            for(1 => int i; i < everyArray.cap(); i++)
            {
                0 => everyArray[i];
            }
        }
        return everyArray;
    }
    public int[] every(int note, int parameter)
    // fills an array -parameter sized-  with note 
    {
        int everyArray[parameter];
        
        note => everyArray[0];
        
        for(1 => int i; i < everyArray.cap(); i++)
        {
            0 => everyArray[i];
        }
        
        return everyArray;
    }
    public int[] transpose(int pattern[], int param)
    // transpose note by param
    {
        int newPattern[pattern.cap()];
        
        for(0 => int i; i < pattern.cap(); i++)
        {
            pattern[i] + param => newPattern[i];
        }
        return newPattern;
    }
    public int[] rotate(int pattern[])
    // rotates int array pattern by one
    {
        int newPattern[pattern.cap()];
        
        pattern[pattern.cap()-1] => newPattern[0];
        
        for(0 => int i; i < (pattern.cap()-1); i++)
        {
            pattern[i] => newPattern[i+1];
        }
        return newPattern;
    }
    public int[] rotate(int pattern[], int move)
    // rotates int array pattern by move positions
    {
        int newPattern[pattern.cap()];
        
        repeat(move)
        {
            rotate(pattern) @=> newPattern;
            newPattern @=> pattern;
        }
        return pattern;
    }
    public int counter(int pattern[])
    // retunrs the number of non zero positions in int array
    {
        0 => int notesOn;
        
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] != 0)
            {
                1 +=> notesOn; 
            }
        }
        return notesOn;
    }
    public int counter(float pattern[])
    // returns the number of non zero positions in float array
    {
        0 => int notesOn;
        
        for(0 => int i; i < pattern.cap(); i++)
        {
            if(pattern[i] != 0)
            {
                1 +=> notesOn; 
            }
        }
        return notesOn;
    }
    public int[] density(int pattern[], float parameter)
    //densify or degrade an array with a float parameter as percentage
    {   
        int toReturn[pattern.cap()];
        pattern.cap() => float size;
        
        if(parameter >= 0 && parameter <= 1)
        {
            Std.ftoi(size * parameter) => int toAdd;
            
            if(counter(pattern) == toAdd) pattern @=> toReturn;
            
            else
            {
                if(counter(pattern) > toAdd)
                {
                    counter(pattern) - toAdd => int c;
                    
                    while(c > 0) 
                    {
                        for(0 => int i; i < pattern.cap(); i++)
                        {
                            if(pattern[i] != 0 && maybe)
                            {
                                0 => pattern[i];
                                1 -=> c;
                            }
                            if(c == 0) break;
                        }
                    }
                    pattern @=> toReturn;
                }
                if(counter(pattern) < toAdd)
                {
                    toAdd - counter(pattern) => int c;
                    
                    while(c > 0) 
                    {
                        for(0 => int i; i < pattern.cap(); i++)
                        {
                            if(pattern[i] == 0 && maybe)
                            {
                                1 => pattern[i];
                                1 -=> c;
                            }
                            if(c == 0) break;
                        }
                    }
                    pattern @=> toReturn;
                }
            }
        }
        else
        {
            <<< "Parameter must be a number between 0 and 1">>>;  
        }
        return toReturn;
    }
    public int[] palindrome(int pattern[])
    // returns the same patern and the reversed appended
    {
        int toReturn[(pattern.cap()*2)];
        (pattern.cap()*2) -1 => int countDown; 
        
        for(0 => int i; i < pattern.cap(); i++)
        {
            pattern[i] => toReturn[i];
            pattern[i] => toReturn[countDown];
            1 -=> countDown;
        }
        return toReturn;
    }
    //------------- time convertion functions ----------------//
    private dur convert(float beat)
    // ftod - beat(float) convertion to dur
    {
        Std.fabs(beat) => beat;
        
        60/beat => float tempo;
        return tempo::second;
    }
    private float convertD(dur beat)
    {
        ((60::second/beat)$float) => float tempo;
        return tempo;
    }
    private dur Dur(dur beat, int div)
    {
        Std.abs(div) => div;
        
        (div / 4.0) => float factor;
        (beat / factor) => dur tempo;
        return tempo;
    }
    // Notes class
    public string[] allNotes()
    {
        ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"] @=> string allNotes[];
        return allNotes;
    }
    private string[][] AllNotes()
    {
        [["C","c","do","Do","DO"],["C#","c#","do#","Do#","DO#","Db","db","reb","Reb","REb"],
        ["D","d","re","Re","RE"],["D#","d#","re#","Re#","RE#","Eb","eb","mib","Mib","MIb"],
        ["E","e","mi","Mi","MI"],["F","f","fa","Fa","FA"],
        ["F#","f#","fa#","Fa#","FA#","Gb","gb","Solb","solb","SOLb"],["G","g","Sol","sol","SOL"],
        ["G#","g#","Sol#","sol#","SOL#","Ab","ab","lab","Lab","LAb"],["A","a","la","La","LA"],
        ["A#","a#","la#","La#","LA#","Bb","bb","sib","Sib","SIb"],["B","b","si","Si","SI"]] @=> string AllNotes[][];
        return AllNotes;
    }
    public string randomNote()
    {
        allNotes() @=> string all[];
        return all[Math.random2(0,(all.cap()-1))];
    }
    public string ftos(float freq) // frecuency to string notation
    {
        return mtos((Std.ftom(freq)$int));
    }
    public float stof(string note, int octave) // string notation to frecuency
    {
        octave * 12 => int factor;
        return Std.mtof(stom(note) + factor);
    }
    public int stom(string notes) //string notation to midi note
    {
        for(0 => int i; i < AllNotes().cap(); i++ )
        {
            for(0 => int ii; ii < AllNotes()[i].cap(); ii++ )
            {
                if(AllNotes()[i][ii] == notes)
                {
                    return i;
                }
            }
        }
    }
    public int stom(string notes, int octave)
    {
        stom(notes) + (octave*12) => int converted;
        return converted;
    }
    public string mtos(int notes) // midi note to string notation
    {
        if(notes < 12) 
        {
            return AllNotes()[notes][0];
        }
        if(notes >= 12)
        {
            notes % 12 => int pos;
            return AllNotes()[pos][0];
        }
    }
    public float[] mtofArray(int notes[])
    {
        float converted[0];
        
        for(0 => int i; i < notes.cap(); i++ )
        {
            converted << Std.mtof(notes[i]);
        }
        return converted;
    }
    public int[] stodArray(string Key, string notes[]) //string to degree
    {
        int converted[0];
        
        for(0 => int i; i < notes.cap(); i++ )
        {
            for(0 => int ii; ii < key(Key).cap(); ii++ )
            {
                if(notes[i] == key(Key)[ii])
                {
                    converted << ii;
                }
            }
        }
        return converted;
    }
    public int[] stomArray(string notes[])
    {
        int converted[0];
        
        for(0 => int i; i < notes.cap(); i++ )
        {
            converted << stom(notes[i]);
        }
        return converted;
    }
    public string[] mtosArray(int notes[])
    {        
        string converted[0];
        
        for(0 => int i; i < notes.cap(); i++ )
        {
            converted << mtos(notes[i]);
        }
        return converted;
    }
    public int[] voicing(string note)
    {
        int chords[];
        
        if(note == "A" || note == "a" || note == "la" || note == "La")
        {
            [61,69,64,68,81,73,86,93,83,80,85,88,0] @=> chords;
            return chords;
        }  
        if(note == "A#" || note == "a#" || note == "la#" || note == "La#" || note == "Bb" || note == "bb" || note == "sib" || note == "Sib")
        {
            [62,70,65,69,82,74,87,94,84,81,86,89,0] @=> chords;
            return chords;
        }   
        if(note == "B" || note == "b" || note == "si" || note == "Si")
        {
            [63,71,66,70,83,75,88,95,85,82,87,90,0] @=> chords;
            return chords;
        }   
        if(note == "C" || note == "c" || note == "do" || note == "Do")
        {
            [60,67,64,71,74,72,76,79,81,96,86,95,0] @=> chords;
            return chords;
        } 
        if(note == "C#" || note == "c#" || note == "do#" || note == "Do#" || note == "Db" || note == "db" || note == "reb" || note == "Reb")
        {
            [61,68,65,72,75,73,77,80,82,97,87,96,0] @=> chords;
            return chords;
        } 
        if(note == "D" || note == "d" || note == "re" || note == "Re")
        {
            [62,69,66,73,76,74,78,81,83,98,88,97,0] @=> chords;
            return chords;
        } 
        if(note == "D#" || note == "d#" || note == "re#" || note == "Re#" || note == "Eb" || note == "eb" || note == "mib" || note == "Mib")
        {
            [63,70,67,62,75,86,72,79,87,86,89,94,0] @=> chords;
            return chords;
        } 
        if(note == "E" || note == "e" || note == "mi" || note == "Mi")
        {
            [64,71,68,63,76,87,73,80,88,87,90,95,0] @=> chords;
            return chords;
        } 
        if(note == "F" || note == "f" || note == "fa" || note == "Fa")
        {
            [65,72,69,64,77,88,74,81,89,88,91,96,0] @=> chords;
            return chords;
        } 
        if(note == "F#" || note == "f#" || note == "fa#" || note == "Fa#" || note == "Gb" || note == "gb" || note == "solb" || note == "Solb")
        {
            [66,73,70,65,78,89,75,82,90,89,92,97,0] @=> chords;
            return chords;
        } 
        if(note == "G" || note == "g" || note == "sol" || note == "Sol")
        {
            [67,71,62,66,86,79,74,83,78,81,76,95,0] @=> chords;
            return chords;
        } 
        if(note == "G#" || note == "g#" || note == "sol#" || note == "Sol#" || note == "Ab" || note == "ab" || note == "lab" || note == "Lab")
        {
            [68,72,63,67,87,80,75,84,79,82,77,96,0] @=> chords;
            return chords;
        } 
        if(note == "A7" || note == "a7" || note == "la7" || note == "La7")
        {
            [61,69,64,67,81,73,86,93,83,80,89,94,0] @=> chords;
            return chords;
        }  
        if(note == "A#7" || note == "a#7" || note == "la#7" || note == "La#7" || note == "Bb7" || note == "bb7" || note == "sib7" || note == "Sib7")
        {
            [62,70,65,68,82,74,87,94,84,81,90,95,0] @=> chords;
            return chords;
        }   
        if(note == "B7" || note == "b7" || note == "si7" || note == "Si7")
        {
            [63,71,66,69,83,75,88,95,85,82,91,96,0] @=> chords;
            return chords;
        }   
        if(note == "C7" || note == "c7" || note == "do7" || note == "Do7")
        {
            [60,67,64,70,74,72,76,79,81,97,86,95,0] @=> chords;
            return chords;
        } 
        if(note == "C#7" || note == "c#7" || note == "do#7" || note == "Do#7" || note == "Db7" || note == "db7" || note == "reb7" || note == "Reb7")
        {
            [61,68,65,71,75,73,77,80,82,98,87,96,0] @=> chords;
            return chords;
        } 
        if(note == "D7" || note == "d7" || note == "re7" || note == "Re7")
        {
            [62,69,66,72,76,74,78,81,83,99,88,97,0] @=> chords;
            return chords;
        } 
        if(note == "D#7" || note == "d#7" || note == "re#7" || note == "Re#7" || note == "Eb7" || note == "eb7" || note == "mib7" || note == "Mib7")
        {
            [63,70,67,61,75,85,72,79,87,85,89,94,0] @=> chords;
            return chords;
        } 
        if(note == "E7" || note == "e7" || note == "mi7" || note == "Mi7")
        {
            [64,71,68,62,76,86,73,80,88,86,90,95,0] @=> chords;
            return chords;
        } 
        if(note == "F7" || note == "f7" || note == "fa7" || note == "Fa7")
        {
            [65,72,69,63,77,87,74,81,89,87,91,96,0] @=> chords;
            return chords;
        } 
        if(note == "F#7" || note == "f#7" || note == "fa#7" || note == "Fa#7" || note == "Gb7" || note == "gb7" || note == "solb7" || note == "Solb7")
        {
            [66,73,70,64,78,88,75,82,90,88,92,97,0] @=> chords;
            return chords;
        } 
        if(note == "G7" || note == "g7" || note == "sol7" || note == "Sol7")
        {
            [67,71,62,65,86,79,74,83,77,81,76,95,0] @=> chords;
            return chords;
        } 
        if(note == "G#7" || note == "g#7" || note == "sol#7" || note == "Sol#7" || note == "Ab7" || note == "ab7" || note == "lab7" || note == "Lab7")
        {
            [68,72,63,66,87,80,75,84,78,82,77,96,0] @=> chords;
            return chords;
        }
        if(note == "Am" || note == "am" || note == "lam" || note == "Lam")
        {
            [60,69,64,67,81,72,74,93,83,79,84,88,0] @=> chords;
            return chords;
        }  
        if(note == "A#m" || note == "a#m" || note == "la#m" || note == "La#m" || note == "Bbm" || note == "bbm" || note == "sibm" || note == "Sibm")
        {
            [61,70,65,68,82,73,75,94,84,80,85,89,0] @=> chords;
            return chords;
        }   
        if(note == "Bm" || note == "bm" || note == "sim" || note == "Sim")
        {
            [62,71,66,69,83,74,76,95,85,81,86,90,0] @=> chords;
            return chords;
        }   
        if(note == "Cm" || note == "cm" || note == "dom" || note == "Dom")
        {
            [60,67,63,70,74,72,76,79,80,96,86,94,0] @=> chords;
            return chords;
        } 
        if(note == "C#m" || note == "c#m" || note == "do#m" || note == "Do#m" || note == "Dbm" || note == "dbm" || note == "rebm" || note == "Rebm")
        {
            [61,68,64,71,75,73,77,80,81,97,87,95,0] @=> chords;
            return chords;
        } 
        if(note == "Dm" || note == "dm" || note == "rem" || note == "Rem")
        {
            [62,69,65,72,76,74,77,81,82,98,89,93,0] @=> chords;
            return chords;
        } 
        if(note == "D#m" || note == "d#m" || note == "re#m" || note == "Re#m" || note == "Ebm" || note == "ebm" || note == "mibm" || note == "Mibm")
        {
            [64,70,66,73,77,75,78,82,83,99,90,94,0] @=> chords;
            return chords;
        } 
        if(note == "Em" || note == "em" || note == "mim" || note == "Mim")
        {
            [64,71,67,62,76,86,72,79,88,86,90,95,0] @=> chords;
            return chords;
        } 
        if(note == "Fm" || note == "fm" || note == "fam" || note == "Fam")
        {
            [65,72,68,63,77,87,73,80,89,87,91,96,0] @=> chords;
            return chords;
        } 
        if(note == "F#m" || note == "f#m" || note == "fa#m" || note == "Fa#m" || note == "Gbm" || note == "gbm" || note == "solbm" || note == "Solbm")
        {
            [66,73,69,64,78,88,74,81,90,88,92,97,0] @=> chords;
            return chords;
        } 
        if(note == "Gm" || note == "gm" || note == "solm" || note == "Solm")
        {
            [67,70,62,65,86,79,74,82,77,81,75,94,0] @=> chords;
            return chords;
        } 
        if(note == "G#m" || note == "g#m" || note == "sol#m" || note == "Sol#m" || note == "Abm" || note == "abm" || note == "labm" || note == "Labm")
        {
            [68,71,63,66,87,80,75,83,78,82,76,95,0] @=> chords;
            return chords;
        } 
    }
    public string[] key(string key)
    {
        string scale[];
        
        if(key == "C" || key == "c" || key == "do" || key == "Do")
        {
            ["C","Dm","Em","F","G7","Am"] @=> scale;
            return scale;
        }
        if(key == "C#" || key == "c#" || key == "do#" || key == "Do#" || key == "Db" || key == "db" || key == "reb" || key == "Reb")
        {
            ["C#","D#m","Fm","F#","G#7","A#m"] @=> scale;
            return scale;
        }
        if(key == "D" || key == "d" || key == "re" || key == "Re")
        {
            ["D","Em","F#m","G","A7","Bm"] @=> scale;
            return scale;
        }
        if(key == "D#" || key == "d#" || key == "re#" || key == "Re#" || key == "Eb" || key == "eb" || key == "mib" || key == "Mib")
        {
            ["Eb","Fm","Gm","Ab","Bb7","Cm"] @=> scale;
            return scale;
        }
        if(key == "E" || key == "e" || key == "mi" || key == "Mi")
        {
            ["E","F#m","G#m","A","B7","C#m"] @=> scale;
            return scale;
        }
        if(key == "F" || key == "f" || key == "fa" || key == "Fa")
        {
            ["F","Gm","Am","Bb","C7","Dm"] @=> scale;
            return scale;
        }
        if(key == "F#" || key == "f#" || key == "fa#" || key == "Fa#" || key == "Gb" || key == "gb" || key == "solb" || key == "Solb")
        {
            ["F#","G#m","A#m","B","C#7","D#m"] @=> scale;
            return scale;
        }
        if(key == "G" || key == "g" || key == "sol" || key == "Sol")
        {
            ["G","Am","Bm","C","D7","Em"] @=> scale;
            return scale;
        }
        if(key == "G#m" || key == "g#m" || key == "sol#m" || key == "Sol#m" || key == "Abm" || key == "abm" || key == "labm" || key == "Labm")
        {
            ["G#","A#m","Cm","C#","D#7","Fm"] @=> scale;
            return scale;
        }
        if(key == "A" || key == "a" || key == "la" || key == "La")
        {
            ["A","Bm","C#m","D","E#","F#m"] @=> scale;
            return scale;
        }
        if(key == "A#" || key == "a#" || key == "la#" || key == "La#" || key == "Bb" || key == "bb" || key == "sib" || key == "Sib")
        {
            ["Bb","Cm","Dm","Eb","F7","Gm"] @=> scale;
            return scale;
        }
        if(key == "B" || key == "b" || key == "si" || key == "Si")
        {
            ["B","C#m","D#m","E","F#7","G#m"] @=> scale;
            return scale;
        }
    }
    public int[] modes (int input)
    {
        int notes[];
        
        if( input == 1 )
        {
            [0, 2, 4, 5, 7, 9, 11] @=> notes; //major scale
            return notes;
        }
        if( input == 2 )
        {
            [0, 2, 3, 5, 7, 9, 10] @=> notes; //dorian
            return notes;
        }
        if( input == 3 )
        {
            [0, 1, 3, 5, 7, 8, 10] @=> notes; //phrygian 
            return notes;  
        }
        if( input == 4 )
        {
            [0, 2, 4, 6, 7, 9, 11] @=> notes; //lydian
            return notes;
        }
        if( input == 5 )
        {
            [0, 2, 4, 5, 7, 8, 10] @=> notes; //mixolydian
            return notes;
        }
        if( input == 6 )
        {
            [0, 2, 3, 5, 7, 8, 10] @=> notes; //aeolyan - minor
            return notes;
        }
        if( input == 7 )
        {
            [0, 1, 3, 5, 6, 8, 10] @=> notes; //locryan
            return notes;
        }
        if( input == 8 )
        {
            [0, 2, 4, 7, 9] @=> notes; //major pentatonic
            return notes;
        }
        if( input == 9 )
        {
            [0, 2, 3, 5, 7, 8, 11] @=> notes; //harmonic minor
            return notes;
        }
        if( input == 10 )
        {
            [0, 2, 3, 5, 7, 9, 11] @=> notes; //ascending melodic minor
            return notes;
        }
        if( input == 11 )
        {
            [0, 1, 4, 5, 7, 8, 10] @=> notes; //phrygian dominant-jewish
            return notes;
        }
        if( input == 12 )
        {
            [0, 2, 3, 6, 7, 8, 11] @=> notes; //hungarian-gypsy
            return notes;
        }
        if( input == 13 )
        {
            [0, 1, 4, 5, 7, 8, 11] @=> notes; //arabic
            return notes;
        }
        if( input == 13 )
        {
            [0, 2, 4, 6, 8, 10] @=> notes; //whole tone
            return notes;
        }
        if( input == 14 )
        {
            [0, 2, 3, 5, 6, 8, 9, 11] @=> notes; //diminished
            return notes;
        }
        if( input == 15 )
        {
            [0, 2, 4, 6, 7, 9, 10] @=> notes;//pseudo indian lydian
            return notes;
        }
        else
        {
            <<<"Number between 1 and 15">>>;
        }     
    }
    public string[] ptos(int prog[], string Key) // convert progression to string
    {
        string converted[0];
        key(Key) @=> string  reference[];
        
        for(0 => int i; i < prog.cap(); i++)
        {
            converted << reference[prog[i]];
        }
        return converted;
    }
    public int[] randomProgression()
    {
        return progression(Math.random2(1,12));
    }
    public int[] progression(int input)
    {
        int prog[];
        
        if(input == 1)
        {
            [5,5,2,2] @=> prog;
            return prog;
        }
        if(input == 2)
        {
            [5,5,4,4] @=> prog;
            return prog;
        }
        if(input == 3)
        {
            [5,3,4,2] @=> prog;
            return prog;
        }
        if(input == 4)
        {
            [0,0,4,4] @=> prog;
            return prog;
        }
        if(input == 5)
        {
            [0,0,3,3] @=> prog;
            return prog;
        }
        if(input == 6)
        {
            [0,0,5,5] @=> prog;
            return prog;
        }
        if(input == 7)
        {
            [0,4,5,3] @=> prog;
            return prog;
        }
        if(input == 8)
        {
            [0,4,3,4] @=> prog;
            return prog;
        }
        if(input == 9)
        {
            [5,3,0,4] @=> prog;
            return prog;
        }
        if(input == 10)
        {
            [5,4,3,4] @=> prog;
            return prog;
        }
        if(input == 11)
        {
            [3,3,4,4] @=> prog;
            return prog;
        }
        if(input == 12)
        {
            [1,4,0,5] @=> prog;
            return prog;
        }
    }
    // Harmony class
    Gain NormalizeHar => Gain volHarmony => NRev revHarmony => MasterChmusick => outlet;

    0.08 => NormalizeHar.gain; // don't change this
    0.3 => revHarmony.mix;

    3 => int numVoices;

    (1.0 / numVoices) => float partialGain;

    string NotesHar[0];

    public float gain(float volum)
    {
        volum => volHarmony.gain;
        return volHarmony.gain();
    }
    public float gain()
    {
        return volHarmony.gain();
    }
    public int voices(int num)
    {
        num => numVoices;
        return numVoices;
    }
    public int voices()
    {
        return voices(numVoices);
    }
    public string[] setNotesHar(string notes[])
    {
        notes @=> NotesHar;
        return NotesHar; 
    }
    public string[] setNotesHar()
    {
        return NotesHar;
    }
    public void sinOsc(string note[])
    {
        sinOsc(note,numVoices);
    }
    public void sinOsc(string note[],int voices)
    {
        voices => numVoices;
        setNotesHar(note);
    
        SinOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => NormalizeHar;
            partialGain => polyphony[i].gain;
        }   
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                if(note[i] != "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        partialGain => polyphony[i].gain;
                    } 
                    voicing(note[i]) @=> int harmony[];
                    for(0 => int i; i < polyphony.cap(); i++)
                    {
                        Std.mtof(harmony[i]) => polyphony[i].freq;                
                    }
                    (convert(TEMPO) * MEASURE) => now;  
                }
                if(note[i] == "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        0 => polyphony[i].gain;
                    } 
                    (convert(TEMPO) * MEASURE) => now;  
                }
            }
        }
    }
    public void sqrOsc(string note[])
    {
        sqrOsc(note,numVoices);
    }
    public void sqrOsc(string note[],int voices)
    {
        voices => numVoices;
        setNotesHar(note);
        
        SqrOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => NormalizeHar;
            partialGain => polyphony[i].gain;
        }   
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                if(note[i] != "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        partialGain => polyphony[i].gain;
                    } 
                    voicing(note[i]) @=> int harmony[];
                    
                    for(0 => int i; i < polyphony.cap(); i++)
                    {
                        Std.mtof(harmony[i]) => polyphony[i].freq;                
                    }
                    (convert(TEMPO) * MEASURE) => now;  
                }
                if(note[i] == "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        0 => polyphony[i].gain;
                    } 
                    (convert(TEMPO) * MEASURE) => now;  
                }
            }
        }
    }
    public void triOsc(string note[])
    {
        triOsc(note,numVoices);
    }
    public void triOsc(string note[],int voices)
    {
        voices => numVoices;
        setNotesHar(note);
        
        TriOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => NormalizeHar;
            partialGain => polyphony[i].gain;
        }  
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                if(note[i] != "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        partialGain => polyphony[i].gain;
                    } 
                    voicing(note[i]) @=> int harmony[];
                    
                    for(0 => int i; i < polyphony.cap(); i++)
                    {
                        Std.mtof(harmony[i]) => polyphony[i].freq;                
                    }
                    (convert(TEMPO) * MEASURE) => now;  
                }
                if(note[i] == "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        0 => polyphony[i].gain;
                    } 
                    (convert(TEMPO) * MEASURE) => now;  
                }
            }
        }
    }
    public void sawOsc(string note[])
    {
        sawOsc(note,numVoices);
    }
    public void sawOsc(string note[],int voices)
    {
        voices => numVoices;
        setNotesHar(note);
        
        SawOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => NormalizeHar;
            partialGain => polyphony[i].gain;
        }  
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                if(note[i] != "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        partialGain => polyphony[i].gain;
                    } 
                    voicing(note[i]) @=> int harmony[];
                    
                    for(0 => int i; i < polyphony.cap(); i++)
                    {
                        Std.mtof(harmony[i]) => polyphony[i].freq;                
                    }
                    (convert(TEMPO) * MEASURE) => now;  
                }
                if(note[i] == "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        0 => polyphony[i].gain;
                    } 
                    (convert(TEMPO) * MEASURE) => now;  
                }
            }
        }
    }
    public void pulseOsc(string note[])
    {
        pulseOsc(note,numVoices);
    }
    public void pulseOsc(string note[],int voices)
    {
        voices => numVoices;
        setNotesHar(note);
        
        PulseOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => NormalizeHar;
            partialGain => polyphony[i].gain;
        }
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                if(note[i] != "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        partialGain => polyphony[i].gain;
                    } 
                    voicing(note[i]) @=> int harmony[];
                    
                    for(0 => int i; i < polyphony.cap(); i++)
                    {
                        Std.mtof(harmony[i]) => polyphony[i].freq;                
                    }
                    (convert(TEMPO) * MEASURE) => now;  
                }
                if(note[i] == "") {
                    for (0 => int i; i < polyphony.cap(); i++)
                    {
                        0 => polyphony[i].gain;
                    } 
                    (convert(TEMPO) * MEASURE) => now;  
                }
            }
        }
    }
    // Drum class
    OscOut oscout;
    FileIO rythyms;

    oscout.dest(this.host(),this.port());
    rythyms.open(me.dir() + "/favoriteRythyms.txt", FileIO.READ);

    Gain Normalizehh => Gain volDrum => MasterChmusick;
    Gain Normalizesn => volDrum;
    Gain Normalizebd => volDrum;

    Gain hhgain => Normalizehh;
    Gain sngain => Normalizesn;
    Gain bdgain => Normalizebd;

    0.2 => Normalizehh.gain; //don't change this
    0.45 => Normalizesn.gain; //don't change this
    0.9 => Normalizebd.gain; //don't change this

    SndBuf Kick[8]; SndBuf Snare[12]; SndBuf HH[9];

    //--------samples for bass drum------//
    me.dir() + "/Drum Kits/Electronica/Kick_Electronica (1).wav" => Kick[0].read;
    me.dir() + "/Drum Kits/Electronica/Kick_Electronica (2).wav" => Kick[1].read; 
    me.dir() + "/Drum Kits/Electronica/Kick_Electronica (3).wav" => Kick[2].read; 
    me.dir() + "/Drum Kits/Hip Hop/Kick (1).wav" => Kick[3].read;
    me.dir() + "/Drum Kits/Hip Hop/Kick (2).wav" => Kick[4].read;
    me.dir() + "/Drum Kits/Hip Hop/Kick (3).wav" => Kick[5].read;
    me.dir() + "/Drum Kits/Vintage Drum/kick a.wav" => Kick[6].read;
    me.dir() + "/Drum Kits/Vintage Drum/kick b.wav" => Kick[7].read;
    //samples for snare drum//
    me.dir() + "/Drum Kits/Electronica/Claps and Snare_Electronica (1).wav" => Snare[0].read;
    me.dir() + "/Drum Kits/Electronica/Claps and Snare_Electronica (2).wav" => Snare[1].read;
    me.dir() + "/Drum Kits/Electronica/Claps and Snare_Electronica (3).wav" => Snare[2].read;
    me.dir() + "/Drum Kits/Electronica/Claps_Electronica (1).wav"=> Snare[3].read;
    me.dir() + "/Drum Kits/Electronica/Claps_Electronica (2).wav"=> Snare[4].read;
    me.dir() + "/Drum Kits/Electronica/Claps_Electronica (3).wav"=> Snare[5].read;
    me.dir() + "/Drum Kits/Hip Hop/Snare - Clap (1).wav" => Snare[6].read;
    me.dir() + "/Drum Kits/Hip Hop/Snare - Clap (2).wav" => Snare[7].read;
    me.dir() + "/Drum Kits/Hip Hop/Snare - Clap (3).wav" => Snare[8].read;
    me.dir() + "/Drum Kits/Hip Hop/Snare - Clap (4).wav" => Snare[9].read;
    me.dir() + "/Drum Kits/Vintage Drum/snare a.wav" => Snare[10].read;
    me.dir() + "/Drum Kits/Vintage Drum/snare b.wav" => Snare[11].read;
    //sample for hhSounds//
    me.dir() + "/Drum Kits/Electronica/Hit_Hat_Electronica (1).wav" => HH[0].read;
    me.dir() + "/Drum Kits/Electronica/Hit_Hat_Electronica (2).wav" => HH[1].read;
    me.dir() + "/Drum Kits/Electronica/Hit_Hat_Electronica (3).wav" => HH[2].read;
    me.dir() + "/Drum Kits/Hip Hop/Hihat - Shaker (1).wav" => HH[3].read;
    me.dir() + "/Drum Kits/Hip Hop/Hihat - Shaker (2).wav" => HH[4].read;
    me.dir() + "/Drum Kits/Hip Hop/Hihat - Shaker (3).wav" => HH[5].read;
    me.dir() + "/Drum Kits/Hip Hop/Hihat (1).wav" => HH[6].read;
    me.dir() + "/Drum Kits/Hip Hop/Hihat (2).wav" => HH[7].read;
    me.dir() + "/Drum Kits/Hip Hop/Hihat (3).wav" => HH[8].read;

    for(0 => int i; i < Kick.cap(); i++)
    {
        Kick[i] => bdgain;
        Kick[i].samples() => Kick[i].pos;
    }
    for(0 => int i; i < Snare.cap(); i++)
    { 
        Snare[i] => sngain;
        Snare[i].samples() => Snare[i].pos;
    }
    for(0 => int i; i < HH.cap(); i++)
    {   
        HH[i] => hhgain;
        HH[i].samples() => HH[i].pos;
    }

    7 => int Refill;

    0 => int randomSize;

    0 => int bdSound;
    9 => int snSound;
    8 => int hhSound;

    8 => int Division;

    [1] @=> int hhGlobal[];
    [1] @=> int snGlobal[];
    [1] @=> int bdGlobal[];

    int rythym[0][0]; 

    public float bdGain(float volum)
    {
        volum => bdgain.gain;
        return bdgain.gain();
    }
    public float bdGain()
    {
        return  bdgain.gain();
    }
    public float snGain(float volum)
    {
        volum => sngain.gain;
        return sngain.gain();
    }
    public float snGain()
    {
        return  sngain.gain();
    }
    public float hhGain(float volum)
    {
        volum => hhgain.gain;
        return hhgain.gain();
    }
    public float hhGain()
    {
        return  hhgain.gain();
    }
    
    public int subdivision(int div)
    {
        div => Division;
        return Division;
    }
    public int subdivision()
    {
        return subdivision(Division);
    }
    public int BDSound(int num)
    {
        num => bdSound;
        return bdSound;
    }
    public int BDSound()
    {
        return BDSound(bdSound);
    }
    public int SNSound(int num)
    {
        num => snSound;
        return snSound;
    }
    public int SNSound()
    {
        return SNSound(snSound);
    }
    public int HHSound(int num)
    {
        num => hhSound;
        return hhSound;
    }
    public int HHSound()
    {
        return HHSound(hhSound);
    }
    public int fillEach(int refillC)
    {
        refillC => Refill;
        return Refill;
    }
    public int fillEach()
    {
        return fillEach(Refill);
    }
    public int[][] favorite(int num)
    {
        return FavoriteArrayDrum[num];
    }
    public int[][] randomFavorite(int num)
    {
        return ArrayDrum[num];
    }
    private void saveFavorite(int k[], int sn[], int hh[])
    {
        rythyms.open(me.dir() + "/favoriteRythyms.txt", FileIO.WRITE);
        rythyms.size() => rythyms.seek;
        
        for(0 => int i; i < ArrayDrum.cap(); i++)
        {
            for(0 => int ii; ii < ArrayDrum[i].cap(); ii++)
            {
                for(0 => int iii; iii < ArrayDrum[i][ii].cap(); iii++)
                {
                    rythyms <= ArrayDrum[i][ii][iii];
                    rythyms <= " ";
                }
            }
            rythyms <= "\n";
        }
        rythyms.close();
    }
    private void event(int k[],int sn[] ,int hh[])
    {   
        saveFavorite(k,sn,hh);
        [k,sn,hh] @=> rythym;
        
        Hid hi;
        HidMsg msg;
        
        0 => int device;
        
        if( me.args() ) me.arg(0) => Std.atoi => device;
        
        if( !hi.openKeyboard( device ) ) me.exit();
        <<<"Press -?- key to save random to favorites">>>;
        
        while (true)
        {
            hi => now;
            
            while( hi.recv( msg ) )
            {
                if( msg.isButtonDown())
                {
                    if( msg.which == 45)
                    {
                        saveFavorite(k,sn,hh);
                        ArrayDrum << rythym;
                        <<<"Stored">>>;
                    }
                }
            }
        }
    }
    public void randomDrum()
    {
        Math.random2(0,Math.random2(0,32)) => int capacity;
        randomDrum(Division,capacity);
    }
    public void randomDrum(int capacity)
    {
        randomDrum(Division,capacity);
    }
    public void randomDrum(int div, int capacity)
    {
        rand(capacity) @=> int kick[];
        rand(capacity) @=> int snare[];
        rand(capacity) @=> int hh[];
        
        spork~ drumF(kick,snare,hh);
        spork~ event(kick,snare,hh);  
        while(true) 1::second => now;
    }
    public void bdRandomFill(int capacity)
    {
        rand(capacity) @=> int kick[];
        
        bdFill(kick);
    }
    public void hhRandomFill(int capacity)
    {
        rand(capacity) @=> int hihat[];
        
        hhFill(hihat);
    }
    public void snRandomFill(int capacity)
    {
        rand(capacity) @=> int snare[];
        
        snFill(snare);
    }
    public void randomFill(int capacity, int capHH)
    {
        rand(capacity) @=> int kick[];
        rand(capacity) @=> int hh[];
        
        fill(kick,hh);
    }
    public void randomFill(int capacity)
    {
        rand(capacity) @=> int kick[];
        rand(capacity) @=> int snare[];
        rand(capacity) @=> int hh[];
        
        fill(kick,snare,hh);
    }
    private void bdFill (int k[])
    {
        for(0 => int i; i < k.cap(); i++)
        {
            if (k[i] == 1)
            {
                0 => Kick[bdSound].pos;
                Math.random2f(0.5,1) => Kick[bdSound].gain;
            }
            Dur(convert(TEMPO),Division) => now;
        } 
    }
    private void hhFill (int hh[])
    {        
        for(0 => int i; i < hh.cap(); i++)
        {
            if (hh[i] == 1)
            {
                0 => HH[hhSound].pos;
                Math.random2f(0.5,1) => HH[hhSound].gain;
            }
            Dur(convert(TEMPO),Division) => now;
        } 
    }
    private void snFill (int sn[])
    {        
        for(0 => int i; i < sn.cap(); i++)
        {
            if (sn[i] == 1)
            {
                0 => Snare[snSound].pos;
                Math.random2f(0.5,1) => Snare[snSound].gain;
            }
            Dur(convert(TEMPO),Division) => now;
        } 
    }
    private void fill (int k[], int hh[])
    {        
        for(0 => int i; i < k.cap() && i < hh.cap(); i++)
        {
            if (k[i] == 1)
            {
                0 => Kick[bdSound].pos;
                Math.random2f(0.5,1) => Kick[bdSound].gain;
            }
            if (hh[i] == 1)
            {
                0 => HH[hhSound].pos;
                Math.random2f(0.5,1) => HH[hhSound].gain;
            }
            Dur(convert(TEMPO),Division) => now;
        } 
    }
    private void fill (int k[],int s[],int hh[])
    {        
        for(0 => int i; i < k.cap() && i < s.cap() && i < hh.cap(); i++)
        {
            if (k[i] == 1)
            {
                0 => Kick[bdSound].pos;
                Math.random2f(0.5,1) => Kick[bdSound].gain;
            }
            if (s[i] == 1)
            {
                0 => Snare[snSound].pos;
                Math.random2f(0.5,1) => Snare[snSound].gain;
            }
            if (hh[i] == 1)
            {
                0 => HH[hhSound].pos;
                Math.random2f(0.5,1) => HH[hhSound].gain;
            }
            Dur(convert(TEMPO),Division) => now;
        } 
    }
    //------------------set Global variables--------------------//
    public int[] bd(int bd[])
    {
        bd.size() => bdGlobal.size;
        bd @=> bdGlobal;
        return bdGlobal;
    }
    public int[] hh(int hh[])
    {
        hh.size() => hhGlobal.size;
        hh @=> hhGlobal;
        return hhGlobal;
    }
    public int[] sn(int sn[])
    {
        sn.size() => snGlobal.size;
        sn @=> snGlobal;
        return snGlobal;
    }
    //--------------------no argument funtion ----------------------//
    public int[] bd ()
    {
        bassDrum(bdGlobal);
        return bdGlobal;
    }
    public int[] bdF ()
    {
        bassDrumF(bdGlobal);
        return bdGlobal;
    }
    public int[] sn ()
    {
        snare(snGlobal);
        return snGlobal;
    }
    public int[] snF ()
    {
        snareF(snGlobal);
        return snGlobal;
    }
    public int[] hh ()
    {
        hihat(hhGlobal);
        return hhGlobal;
    }
    public int[] hhF ()
    {
        hihatF(hhGlobal);
        return hhGlobal;
    }
    
    //--------------------Drum with Fill-------------------------//
    public void drumF (int k[])
    {
        bassDrumF(k);
    }
    public void drumF (int k[],int hh[])
    {
        spork~ bassDrumF(k);
        spork~ hihatF(hh);
        while(true) 1::ms => now;
    }
    public void drumF (int k[],int s[],int hh[])
    {
        spork~ bassDrumF(k);
        spork~ snareF(s);
        spork~ hihatF(hh);
        while(true) 1::ms => now;
    }
    public void drumF (int full[][])
    {   
        if(full.cap() == 3)
        {             
            spork~ bassDrumF(full[0]);
            spork~ snareF(full[1]);
            spork~ hihatF(full[2]);
            while(true) 1::ms => now;
        }
        if(full.cap() == 2)
        {             
            spork~ bassDrumF(full[0]);
            spork~ hihatF(full[1]);
            while(true) 1::ms => now;
        }
    }
    //--------------------Drum without fill------------------------//
    public int[] drum ()
    {
        spork~ bassDrum(bdGlobal);
        spork~ snare(snGlobal);
        spork~ hihat(hhGlobal);
        while(true) 1::ms => now;
        return bdGlobal,snGlobal,hhGlobal;
    }
    public int[] drum (int k[])
    {
        bassDrum(k);
        return k;
    }
    public int[] drum (int k[],int hh[])
    {
        spork~ bassDrum(k);
        spork~ hihat(hh);
        while(true) 1::ms => now;
        return k,hh;
    }
    public int[] drum (int k[],int s[],int hh[])
    {
        spork~ bassDrum(k);
        spork~ snare(s);
        spork~ hihat(hh);
        while(true) 1::ms => now;
        return k,s,hh;
    }
    public int[] drum (int full[][])
    {                
        if(full.cap() == 3)
        {             
            spork~ bassDrum(full[0]);
            spork~ snare(full[1]);
            spork~ hihat(full[2]);
            while(true) 1::ms => now;
        }
        if(full.cap() == 2)
        {             
            spork~ bassDrum(full[0]);
            spork~ hihat(full[1]);
            while(true) 1::ms => now;
        }
        return full[0],full[1],full[2];
    }
    //-----------------Basic Functions---------------------//
    private int[] bassDrumF (int k[])
    {
        k @=> bdGlobal;
        
        0 => int count;
        
        while(count < Refill)
        {
            for(0 => int i; i < k.cap(); i++)
            {
                if (k[i] == 1)
                {
                    0 => Kick[bdSound].pos;
                    Math.random2f(0.5,1) => Kick[bdSound].gain;
                }
                Dur(convert(TEMPO),Division) => now;
            }
            count ++;
            
            if(count == Refill) 
            {
                bdRandomFill(k.cap());
                0 => count;
            }
        }
        return k;
    }
    private int[] bassDrum (int k[])
    {        
        k @=> bdGlobal;
        
        while(true)
        {
            for(0 => int i; i < k.cap(); i++)
            {
                if (k[i] == 1)
                {
                    0 => Kick[bdSound].pos;
                    Math.random2f(0.5,1) => Kick[bdSound].gain;
                    oscout.start("/bd");
                    oscout.add(1);
                    oscout.send();
                    Dur(convert(TEMPO),Division) => now;
                }
                if (k[i] == 0) {
                    oscout.start("/bd");
                    oscout.add(0);
                    oscout.send();
                    Dur(convert(TEMPO),Division) => now;
                }
            }
        }
        return k;
    }
    private int[] hihat (int hh[])
    {       
        hh @=> hhGlobal;
        
        while(true)
        {
            for(0 => int i; i < hh.cap(); i++)
            {
                if (hh[i] == 1)
                {
                    0 => HH[hhSound].pos;
                    Math.random2f(0.5,1) => HH[hhSound].gain;
                }
                Dur(convert(TEMPO),Division) => now;
            }
        }
        return hh;
    }
    private int[] hihatF (int hh[])
    {
        hh @=> hhGlobal;
        
        0 => int count;
        
        while(count < Refill)
        {
            for(0 => int i; i < hh.cap(); i++)
            {
                if (hh[i] == 1)
                {
                    0 => HH[hhSound].pos;
                    Math.random2f(0.5,1) => HH[hhSound].gain;
                }
                Dur(convert(TEMPO),Division) => now;
            }
            count ++;
            
            if(count == Refill) 
            {
                hhRandomFill(hh.cap());
                0 => count;
            }
        }
        return hh;
    }
    private int[] snare (int sn[])
    {        
        sn @=> snGlobal;
        
        while(true)
        {
            for(0 => int i; i < sn.cap(); i++)
            {
                if (sn[i] == 1)
                {
                    0 => Snare[snSound].pos;
                    Math.random2f(0.5,1) => Snare[snSound].gain;
                }
                Dur(convert(TEMPO),Division) => now;
            } 
        }
        return sn;
    }
    private int[] snareF (int sn[])
    {
        sn @=> snGlobal;
        
        0 => int count;
        
        while(count < Refill)
        {
            for(0 => int i; i < sn.cap(); i++)
            {           
                if (sn[i] == 1)
                {
                    0 => Snare[snSound].pos;
                    Math.random2f(0.5,1) => Snare[snSound].gain;
                }
                Dur(convert(TEMPO),Division) => now;
            }
            count ++;
            
            if(count == Refill) 
            {
                snRandomFill(sn.cap());
                0 => count;
            }
        }
        return sn;
    }
    //Melody class
    ADSR envelopeMel => Gain NormalizeMel => Gain volMel => MasterChmusick;

    0.25 => NormalizeMel.gain; //don't change this

    SinOsc sin; SqrOsc sqr; PulseOsc pulse; SawOsc saw;TriOsc tri;
    [sin,sqr,pulse,saw,tri] @=> Osc osc[];

    0 => int activeOsc;

    BlowBotl BB; BandedWG BWG; Wurley W; TubeBell TB; Bowed bow;
    Rhodey rhod; PercFlut PF; BlowHole BH; HevyMetl HM; ModalBar MB;
    Flute flut; Mandolin mandol; Saxofony sax; Moog mg; Sitar sit; 
    StifKarp SK; BeeThree BT; FMVoices fmv;
    [BB, BWG,W,TB,bow,rhod,PF,BH,flut,mandol,MB,mg,sax,sit,SK,BT,fmv,HM] @=> StkInstrument inst[];

    0 => int activeInst; 

    8 => int DivisionMel;

    int NotesMel[0];

    25::ms => dur AMel;
    25::ms => dur DMel;
    0.5 => float SMel;
    0::ms => dur RMel;

    envelopeMel.set(AMel, DMel, SMel, RMel);

    public float gain(float volum)
    {
        volum => volMel.gain; 
        return volMel.gain();
    }
    public float gain()
    {
        return volMel.gain();
    }
    public int subdivision(int div)
    {
        div => DivisionMel;
        return DivisionMel;
    }
    public int subdivision()
    {
        return DivisionMel;
    }
    public int[] setNotesMel(int notes[])
    {
        notes @=> NotesMel;
        return NotesMel; 
    }
    public int[] setNotesMel()
    {
        return NotesMel;
    }
    public dur attackMel(dur attacK)
    {
        attacK => AMel;
        return AMel;
    }
    public dur attackMel()
    {
        return attackMel(AMel);
    }
    public dur decayMel(dur decaY)
    {
        decaY => DMel;
        return DMel;
    }
    public dur decayMel()
    {
        return decayMel(DMel);
    }
    public float sustainMel(float sustaiN)
    {
        sustaiN => SMel;
        return SMel;
    }
    public float sustainMel()
    {
        return sustainMel(SMel);
    }
    public dur releaseMel(dur releasE)
    {
        releasE => RMel;
        return RMel;
    }
    public dur releaseMel()
    {
        return releaseMel(RMel);
    }
    public int controlChangeOsc(int parameter)
    {
        parameter => activeOsc;
        if(parameter == 0) 0.6 => NormalizeMel.gain;
        if(parameter == 1) 0.25 => NormalizeMel.gain;
        if(parameter == 2) 0.25 => NormalizeMel.gain;
        if(parameter == 3) 0.25 => NormalizeMel.gain;
        if(parameter == 4) 0.6 => NormalizeMel.gain;
        return activeOsc;
    }
    public int controlChangeOsc()
    {
        return controlChangeOsc(activeOsc);
    }
    public int controlChange(int parameter)
    {
        if(parameter == 0) 0.2 => NormalizeMel.gain;
        if(parameter == 1) 4 => NormalizeMel.gain;
        if(parameter == 2) 0.3 => NormalizeMel.gain;
        if(parameter == 3) 0.3 => NormalizeMel.gain;
        if(parameter == 4) 2.3 => NormalizeMel.gain;
        if(parameter == 5) 0.4 => NormalizeMel.gain;
        if(parameter == 6) 0.4 => NormalizeMel.gain;
        if(parameter == 7) 0.25 => NormalizeMel.gain;
        if(parameter == 8) 0.3 => NormalizeMel.gain;
        if(parameter == 9) 0.35 => NormalizeMel.gain;
        if(parameter == 10) 0.9 => NormalizeMel.gain;
        if(parameter == 11) 0.9 => NormalizeMel.gain;
        if(parameter == 12) 0.17 => NormalizeMel.gain;
        if(parameter == 13) 0.7 => NormalizeMel.gain;
        if(parameter == 14) 0.3 => NormalizeMel.gain;
        if(parameter == 15) 0.3 => NormalizeMel.gain;
        if(parameter == 16) 0.2 => NormalizeMel.gain;
        if(parameter == 17) 0.3 => NormalizeMel.gain;
        
        parameter => activeInst;
        return activeInst;
    }
    public int controlChange()
    {
        return controlChange(activeInst);
    }
    public void synthOsc()
    {
        synthOsc(DivisionMel,NotesMel);
    }
    public void synthOsc(int notes[])
    {
        synthOsc(DivisionMel,notes);
    }
    public void synthOsc(int div,int notes[])
    {
        div => DivisionMel;
        setNotesMel(notes);
        
        osc[activeOsc] => envelopeMel;
        
        while(true)
        {
            for(0 => int i; i < notes.cap(); i++)
            {
                if(notes[i] == 0)
                {
                    0 => osc[activeOsc].gain;
                    envelopeMel.keyOff();
                    Dur(convert(TEMPO),DivisionMel) => now;
                }
                else
                {
                    Std.mtof(notes[i]) => osc[activeOsc].freq;
                    Math.random2f(0.5,1) => osc[activeOsc].gain;
                    envelopeMel.keyOn();
                    Dur(convert(TEMPO),DivisionMel) => now;
                    envelopeMel.keyOff();
                }
            }          
        }
    }
    public void synth()
    {
        synth(DivisionMel,NotesMel);
    }
    public void synth(int notes[])
    {
        synth(DivisionMel,notes);
    }
    public void synth(int div,int notes[])
    {
        div => DivisionMel;
        setNotesMel(notes);
        
        inst[activeInst] => NormalizeMel;
        
        while(true)
        {
            for(0 => int i; i < notes.cap(); i++)
            {
                if(notes[i] == 0)
                {
                    inst[activeInst].noteOff;
                    Dur(convert(TEMPO),DivisionMel) => now;
                }
                else
                {
                    Std.mtof(notes[i]) => inst[activeInst].freq;
                    Math.random2f(0.5,1) => inst[activeInst].gain;
                    1 => inst[activeInst].noteOn;
                    inst[activeInst].noteOn;
                    Dur(convert(TEMPO),DivisionMel) => now;
                    inst[activeInst].noteOff;
                }
            }          
        }
    }
    public void synthT(int times,int div,int notes[])
    {
        div => DivisionMel;
        setNotesMel(notes);
        
        inst[activeInst] => NormalizeMel;
        
        for(0 => int i; i < times; i++)
        {
            for(0 => int i; i < notes.cap(); i++)
            {
                if(notes[i] == 0)
                {
                    inst[activeInst].noteOff;
                    Dur(convert(TEMPO),DivisionMel)/notes.cap() => now;
                }
                else
                {
                    Std.mtof(notes[i]) => inst[activeInst].freq;
                    1 => inst[activeInst].noteOn;
                    inst[activeInst].noteOn;
                    Dur(convert(TEMPO),DivisionMel)/notes.cap() => now;
                    inst[activeInst].noteOff;
                }
            }          
        }
    }
    public int[] granularize(int array[], int howmany)
    {
        (howmany * 8) => DivisionMel;
        
        int granularized[0];
        
        for(0 => int count; count < array.cap(); count++)
        {
            for(0 => int i; i < howmany; i++)
            {
                granularized << array[count];
            }
        }
        return granularized;
    }
    /*public void jux(int pattern[])
    {
        Melody l;
        Melody r;
        controlChange() => l.controlChange;
        controlChange() => r.controlChange;
        l => dac.left;
        r => dac.right;
        spork~l.synth(pattern);
        spork~r.synth(r.reverse(pattern));
        while(true) 1::second => now;
    }*/
    public void metronome(float tempo,int div,int each)
    {
        tempo => Chmusick.TEMPO;
        synthOsc(div,every(100,each));
    }
    //FmSynth class
    SinOsc modulator => ADSR envelopeFM => SinOsc carrier => Envelope envFM => Gain NormalizeFM => MasterChmusick => outlet;

    0.08 => NormalizeFM.gain; //don't change this
        
    SinOsc carrier2;
    8 => float C2f;
    carrier.freq() * C2f => carrier2.freq;
    2 => carrier2.sync;
        
    SinOsc modulator2;
    0.2 => float M2f;
    carrier.freq() * M2f => modulator2.freq; 
    2 => modulator2.gain;
        
    2 => carrier.sync;
    1 => modulator.gain;
        
    3 => float NUM;
    2 => float DEN;
        
    (NUM/DEN) => float mf;
    carrier.freq() * mf => modulator.freq;
        
    10::ms => dur AFM;
    8::ms => dur DFM;
    0.5 => float SFM;
    5::ms => dur RFM;
        
    envelopeFM.set(AFM, DFM, SFM, RFM);
        
    8 => int DivisionFM;
        
    [60,0,0,0] @=> int NotesFM[];
        
    public int subdivisionFM(int div)
    {
        div => DivisionFM;
        return DivisionFM;
    }
    public int subdivisionFM()
    {
        return subdivision(DivisionFM);
    }
    public int[] setNotesFM(int notes[])
    {
        notes @=> NotesFM;
        return NotesFM; 
    }
    public int[] setNotes()
    {
        return NotesFM;
    }    
    public dur attackFM(dur attacK)
    {
        attacK => AFM;
        return AFM;
    }
    public dur attackFM()
    {
        return attackFM(AFM);
    }
    public dur decayFM(dur decaY)
    {
        decaY => DFM;
        return DFM;
    }
    public dur decayFM()
    {
        return decayFM(DFM);
    }
    public float sustainFM(float sustaiN)
    {
        sustaiN => SFM;
        return SFM;
    }
    public float sustainFM()
    {
        return sustainFM(SFM);
    }
    public dur releaseFM(dur releasE)
    {
        releasE => RFM;
        return RFM;
    }
    public dur releaseFM()
    {
        return releaseFM(RFM);
    }
    public int sync(int mode)
    {
        mode => carrier.sync;
        return mode;
    }
    public int sync()
    {
        return carrier.sync();
    }
    public float mfreq(float mf)
    {
        mf => modulator.freq;
        return mf;
    }
    public float mfreq()
    {
        return modulator.freq();
    }
    public float mgain(float mg)
    {
        mg => modulator.gain;
        return modulator.gain();
    }
    public float mgain()
    {
        return modulator.gain();
    }
    public float cfreq(float cf)
    {
        cf => carrier.freq;
        return carrier.freq();
    }
    public float cfreq()
    {
        return carrier.freq();
    }
    public float gainFM(float cg)
    {
        cg => envFM.gain;
        return envFM.gain();
    }
    public float gainFM()
    {
        return carrier.gain();
    }
    public float ratio(float num, float den)
    {
        num => NUM;
        den => DEN;
        (num/den) => mf;
        return mf;
    }
    public float ratio()
    {
        return mf;
    }
    public int c2sync(int mode)
    {
        mode => carrier.sync;
        return mode;
    }
    public int c2sync()
    {
        return carrier.sync();
    }
    public float c2freq(float c2f)
    {   
        c2f => C2f;
        return carrier2.freq();
    }
    public float c2freq()
    {
        return carrier2.freq();
    }
    public float c2gain(float c2g)
    {
        c2g => carrier2.gain;
        return carrier2.gain();
    }
    public float c2gain()
    {
        return carrier2.gain();
    }
    public float m2freq(float m2f)
    {
        m2f => M2f;
        return modulator2.freq();
    }
    public float m2freq()
    {
        return modulator2.freq();
    }
    public float m2gain(float m2g)
    {
        m2g => modulator2.gain;
        return modulator2.gain();
    }
    public float m2gain()
    {
        return modulator2.gain();
    }
    public string fm()
    {
        modulator => carrier => envelopeFM => outlet;
        return "fm";
    }
    public string fmC2()
    {
        modulator => carrier2 => envelopeFM => outlet;
        return "Fm double carrier";
    }
    public string fmM2()
    {
        modulator2 => carrier => envelopeFM => outlet;
        return "FM double modulator";
    }
    public void fmBass()
    {
        fmBass(NotesFM);
    }
    public void fmBass(int div)
    {
        fmBass(div,NotesFM);
    }
    public void fmBass(int notes[])
    {
        fmBass(DivisionFM,notes);
    }
    public void fmBass(int div, int notes[])
    {
        div => DivisionFM;
        setNotesFM(notes);
            
        while(true)
        {
            envelopeFM.set(AFM, DFM, SFM, RFM);
            
            for(0 => int i; i < notes.cap(); i++)
            {
                if(notes[i] == 0)
                {
                    envelopeFM.keyOff();
                    envFM.keyOff();
                    Dur(convert(TEMPO),DivisionFM) => now;
                }
                else
                {
                    oscout.start("/notes");
                    Std.mtof(notes[i]) => carrier.freq;
                    Math.random2f(0.5,1) => carrier.gain;
                    carrier.freq() * mf => modulator.freq;
                    carrier.freq() * C2f => carrier2.freq;
                    carrier.freq() * M2f => modulator2.freq;
                    oscout.add(carrier.freq());
                    oscout.send();
                    envelopeFM.keyOn();
                    envFM.keyOn();
                    Dur(convert(TEMPO),Division)/2 => now;
                    envelopeFM.keyOn();
                    Dur(convert(TEMPO),Division)/2 => now;
                }
            }          
        }
    }
    public int[] granularize(int array[], int howmany)
    {
        (howmany * 8) => Division;
        
        int granularized[0];
        
        for(0 => int count; count < array.cap(); count++)
        {
            for(0 => int i; i < howmany; i++)
            {
                granularized << array[count];
            }
        }
        return granularized;
    }
    /*public void jux(int pattern[])
    {
        FMSynth l;
        FMSynth r;
        l => dac.left;
        r => dac.right;
        spork~l.fmBass(pattern);
        spork~r.fmBass(r.reverse(pattern));
        while(true) 1::second => now;
    }*/
    //Sampler class
    SndBuf buffer => Echo echo => Gain NormalizeSamp => Gain volSamp => Envelope envelopeSamp => MasterChmusick;

    0.6 => NormalizeSamp.gain;
            
    0.05 => echo.mix;
            
    16 => int DivisionSamp;
    //32 => int Division; midi map
            
    "" => string fileName;
            
    [0] @=> int gains[];
            
    public string file(string name, string letter)
    {
        me.dir() + "Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
        //"Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
        fileName => buffer.read;
                
         return fileName;
     }
     public string file(string name, int num)
     {
         me.dir() + "Samples/" + name + "/" + num + ".wav" => fileName; //Mac/Linux conflict with path
         //"Samples/" + name + "/" + num + ".wav" => fileName; //Mac/Linux conflict with path
         fileName => buffer.read;
                
         return fileName;
     }
     public string file(string name)
     {
         file(name, 1);
         return fileName;
     }
     public int[] changeStress(int parameters[])
     {
         int toReturn[parameters.cap()];
                
         parameters.cap() => gains.size;
         parameters @=> gains;
                
         return gains;
     }
     public int[] accelerateSamp(int patterns[], int parameter)
     {
         parameter*DivisionSamp => DivisionSamp;
                
         return patterns;
     }
     public int[] accelerateSamp(int patterns[], int parameter)
     {
         parameter/DivisionSamp => DivisionSamp;
                
         return patterns;
     }
     public void sound(string S, int sample[])
     {
         file(S);
         sound(sample);
     }
     public void sound()
     {
         while(true) {
             envelopeSamp.keyOn();
             0 => buffer.pos;
             buffer.length() => now;
         }
     }
     public void sound(int sample[])
     {
         2 => CYCLES;
                
         while(true)
         {
             for(0 => int i; i < sample.cap(); i++)
             {
                 if (sample[i] == 1)
                 {
                     stress(sample.cap(),gains)[i] => buffer.gain;
                     envelopeSamp.keyOn();
                     0 => buffer.pos;
                 }
                 Dur(convert(TEMPO),DivisionSamp) => now;
                 
                 if (sample[i] == 0)
                 {
                     envelopeSamp.keyOff();
                 }
                 Dur(convert(TEMPO),DivisionSamp) => now;
             }
         }
     }
     public void sound(string sample[])
     {
         60 => TEMPO;
         1 => CYCLES;
                
         while(true)
         {
             for(0 => int i; i < sample.cap(); i++)
             {
                 if (sample[i] != "~")
                 {
                     file(sample[i]);
                     stress(sample.cap(),gains)[i] => buffer.gain;
                     envelopeSamp.keyOn();
                     0 => buffer.pos;
                 }
                 Dur(convert(TEMPO),Division)/sample.cap() => now;
                 
                 if (sample[i] == "~")
                 {
                     envelopeSamp.keyOff();
                 }
                 Dur(convert(TEMPO),DivisionSamp)/sample.cap() => now;
             }
         }
     }
     //Cooker synth
     //SynthDef using Perry Cook's example and STK BlitSaw implementation
     10 => int partial;
            
     BlitSaw s[partial];      
     Gain NormalizeCook => Gain volumCook => NRev revCook => Envelope envCook => MasterChmusick;  
            
     0.15 => revCook.mix;
            
     1.0/partial => NormalizeCook.gain;  
           
     440 => float frq;
            
     8 => int DivisionCook;
            
     0.1 => float Factor;
            
     for (int i; i < partial; i++) 
     {
         partial => s[i].harmonics;       
         s[i] => NormalizeCook; 
     }
     public float gainCook(float parameter)
     {
         parameter => volumCook.gain;
         return volumCook.gain();
     }
     public float gainCook()
     {
         return volumCook.gain();
     }
     public float freqCook(float freq)
     {
         freq => frq;
         return frq;
     }
     public float freqCook()
     {
         return frq;
     }
     public float factor(float f)
     {
         f => Factor;
         return Factor;
     }
     public float factor()
     {
         return Factor;
     }
     public void freqAssign()
     {
         for (int i; i < partial; i++) 
         {                   
             (freqCook() + (factor() * i)) => s[i].freq;
         }
     }
     public void sound(int notes[])
     {
         sound(DivisionCook, notes);
     }
     public void sound(int div,int notes[])
     {
         div => DivisionCook;
         
         while(true)
         {
             for(0 => int i; i < notes.cap(); i++)
             {
                 if(notes[i] == 0)
                 {
                     envCook.keyOff();
                     Dur(convert(TEMPO),DivisionCook) => now;
                 }
                 else
                 {
                     Std.mtof(notes[i]) => freqCook;
                     freqAssign();
                     envCook.keyOn();
                     Dur(convert(TEMPO),DivisionCook) => now;
                 }
             }          
         }
     }
}