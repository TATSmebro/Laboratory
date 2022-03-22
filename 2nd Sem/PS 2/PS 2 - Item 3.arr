fun zip-three(a :: List, b :: List, c :: List) -> List:
    cases (List) a:
        |empty      => empty
        |link(first-a, rest-a)  =>
        cases (List) b:
            |empty      => empty
            |link(first-b, rest-b)  =>
            cases (List) c:
                |empty      => empty
                |link(first-c, rest-c)  => link({first-a; first-b; first-c}, zip-three(rest-a, rest-b, rest-c))
            end
        end
    end
end
 

check:
    zip-three([list: ], [list: 1, 2, 3], [list: 4, 5, 6]) is [list: ]
    zip-three([list: 1, 2], [list: 10, 20], [list: 100, 200]) is [list: {1; 10; 100}, {2; 20; 200}]
    zip-three([list: 1, 2, 3], [list: 10, 20, 30], [list: 100]) is [list: {1; 10; 100}]
end

