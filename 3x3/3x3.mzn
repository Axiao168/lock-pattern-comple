include "globals.mzn";

% Cartesian coordinates
array[int] of int: x = [1, 2, 3, 1, 2, 3, 1, 2, 3];
array[int] of int: y = [1, 1, 1, 2, 2, 2, 3, 3, 3];

% Lock Pattern
array[1..9] of var 1..9: p;
constraint alldifferent(p);

% Differences
array[1..8] of var int: dx = [x[p[i]] - x[p[i+1]] | i in 1..8];
array[1..8] of var int: dy = [y[p[i]] - y[p[i+1]] | i in 1..8];

% Maximum complexity constraints.
% Enforce that there exists one of each line type.
predicate f(int: x1, int: y1, int: x2, int: y2) = exists(i in 1..8)(
    (dx[i] = x1 /\ dy[i] = y1) \/ (dx[i] = x2 /\ dy[i] = y2)
);

constraint f(0, 1, 0, -1) \/ f(0, 2, 0, -2);
constraint f(1, 0, -1, 0) \/ f(2, 0, -2, 0);
constraint f(2, 1, -2, -1);
constraint f(1, 1, -1, -1) \/ f(2, 2, -2, -2);
constraint f(1, 2, -1, -2);
constraint f(-2, 1, 2, -1);
constraint f(-1, 1, 1, -1) \/ f(-2, 2, 2, -2);
constraint f(-1, 2, 1, -2);

% Break symmetries
% TODO: rotations: 0, 90, 180, 270
% TODO: reflections: horizontal, vertical
% constraint symmetry_breaking_constraint(lex_lesseq(p, p));

% Manhattan distance
var int: s = sum(i in 1..8)(abs(dx[i]) + abs(dy[i]));

% Maximize distance
solve maximize s;

% Print output
output ["d=\(p), s=\(s)"];
