var input = File.ReadAllLines("Input/input21.txt");
 
const long totalSteps = 26501365L;
 
var sequenceCounts = new List<(int X, int Y)>();
var visited = new HashSet<(int,int)> { (input.Length / 2, input.Length / 2) };
var steps = 0;
var res1 = 0;
double res2 = 0;

for (var run = 0; run < 3; run++)
{
    for (; steps < run * 131 + 65; steps++) 
    {
        var nextOpen = new HashSet<(int,int)>();
        foreach (var position in visited)
        {
            foreach (var dir in new[] { (-1, 0), (1, 0), (0, -1), (0, 1) })
            {
                var dest = (position.Item1 + dir.Item1 , position.Item2 + dir.Item2);
                if (input[((dest.Item1%131)+131)%131][((dest.Item2%131)+131)%131] != '#')
                {
                    nextOpen.Add((dest.Item1,dest.Item2));
                }
            }
        }
 
        visited = nextOpen;
 
        if (steps == 63)
        {
            res1 = visited.Count;
        }
    }
    sequenceCounts.Add((steps, visited.Count));
}
 
for (var i = 0; i < 3; i++)
{
    double term = sequenceCounts[i].Y;
 
    for (var j = 0; j < 3; j++)
    {
        if (j != i)
        {
            term = term * (totalSteps - sequenceCounts[j].X) / (sequenceCounts[i].X - sequenceCounts[j].X);
        }
    }
 
    res2 += term;
}

Console.WriteLine($"Answer 1: {res1}");
Console.WriteLine($"Answer 2: {res2}");
 
return;
 