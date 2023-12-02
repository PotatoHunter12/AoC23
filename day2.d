import std.stdio;
import std.array;
import std.conv;
import std.range;
import std.string;

void main()
{
    string filePath = "Input/input2.txt";
    auto file = File(filePath, "r");
    
    int[string] max = ["red": 12, "green": 13, "blue": 14];
    int index = 0;
    int sumofindex = 5050;
    
    while(!file.eof)
    {
        bool isGood = true;
        index++;
        string[] game = file.readln().split(":")[1].split(";");

        foreach (string set; game)
        {
            int[string] rgb = ["red": 0, "green": 0, "blue": 0];
            foreach (string color; set.split(","))
            {
                string[] hm = strip(color).split();
                rgb[hm[1]] += to!int(hm[0]);
                if (max[hm[1]] < rgb[hm[1]]){
                    sumofindex -= index;
                    isGood=false;
                    break;
                }
            }
            if (!isGood) break;
        }
        
    }
    file.close();

    file = File(filePath, "r");
    int gameSum = 0;
    
    while(!file.eof)
    {
        string[] game = file.readln().split(":")[1].split(";");
        int[string] gameRgb = ["red": 0, "green": 0, "blue": 0];

        foreach (string set; game)
        {
            int[string] rgb = ["red": 0, "green": 0, "blue": 0];
            foreach (string color; set.split(","))
            {
                string[] hm = strip(color).split();
                rgb[hm[1]] += to!int(hm[0]);
                if (gameRgb[hm[1]] < rgb[hm[1]]) gamergb[hm[1]] = rgb[hm[1]];
            }
        }
        int sum = 1;
        foreach (key, value; gamergb) sum *= value;
        gameSum += sum;
        
    }
    file.close();

    writeln("Answer 1: ", sumofindex);
    writeln("Answer 2?: ",gameSum);
}