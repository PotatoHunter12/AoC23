<?php namespace day17;
use Lib\Heap;
use Lib\solver;
use Illuminate\Support\Collection;

class day17 extends solver
{
    public function solve() : void
    {
        $city = $this->parse_input();
        $this->solution('17a', $this->route($city, 0, 0, 3, 0));
        $this->solution('17b', $this->route($city, 0, 0, 10, 4));
    }

    public function route(Collection $city, int $sx, int $sy, $max_blocks_without_turning = 3, $min_blocks_after_turning = 0) : int
    {
        $w = count($city[0]);
        $h = count($city);
        $q = new Heap;
        $q->insert([0, $sx, $sy, -1, -1, 0, 1, 0], INFINITE);
        $seen = [];

        while($q->count() > 0) {
            [$heat_loss, $x, $y, $px, $py, $dx, $dy, $steps] = $q->extract();

            if ($x === $w-1 && $y === $h -1) {
                if ($steps >= $min_blocks_after_turning) return $heat_loss;
            }

            $key = "{$x}_{$y}_{$dx}_{$dy}_{$steps}";
            if (isset($seen[$key])) continue;

            foreach([[0,-1],[1,0],[0,1],[-1,0]] as [$ndx, $ndy]) {
                $nx = $x+$ndx;
                $ny = $y+$ndy;

                if (out_of_bounds($nx, $ny, $w, $h)) continue;

                if ($nx === $px && $ny === $py) continue;

                $next_heat_loss = $heat_loss + $city[$ny][$nx];

                if ($dx === $ndx && $dy ===  $ndy) {
                    if  ($steps < $max_blocks_without_turning) {
                        $q->insert([$next_heat_loss, $nx, $ny, $x, $y, $dx, $dy, $steps+1], $next_heat_loss);
                    }
                } else {
                    if ($steps >= $min_blocks_after_turning || [$x,$y] === [0,0]) {
                        $q->insert([$next_heat_loss, $nx, $ny, $x, $y, $ndx, $ndy, 1], $next_heat_loss);
                    }
                }
            }
            $seen[$key] = 1;
        }
    }

    public function parse_input() : Collection
    {
        return $this->input->map(fn($m) => collect(str_split($m)));
    }
}