open System
open System.IO

let list = Seq.toList (File.ReadAllLines(@"Input\input10.txt"))
let mutable x,y,dir,steps = 0,0,0,0.0

for i = 0 to list.Length - 1 do
    if (list[i].IndexOf("S") > 0) then
        x <- list[i].IndexOf("S")
        y <- i

let startx,starty = x,y

if x < list[0].Length - 1 && (match list[y][x+1] with | '-' | 'J' | '7' -> true | _ -> false) then
    dir <- 1
elif y < list.Length - 1 && (match list[y+1][x] with | '|' | 'J' | 'L' -> true | _ -> false) then
    dir <- 2
elif x > 0 && (match list[y-1][x] with | '-' | 'F' | 'L' -> true | _ -> false) then
    dir <- 3

let mutable i = 0
while i = 0 do
    if dir % 2 = 0 then
        y <- y + dir - 1
    else
        x <- x - dir + 2

    match list[y][x] with
        | 'L' -> dir <- if dir = 2 then 1 else 0 
        | 'J' -> dir <- if dir = 2 then 3 else 0
        | '7' -> dir <- if dir = 1 then 2 else 3
        | 'F' -> dir <- if dir = 3 then 2 else 1
        | _ -> ()
    steps <- steps + 1.0

    if startx = x && starty = y then
        printfn "%A" (int (Math.Ceiling(steps/2.0)))
        i <- 1
