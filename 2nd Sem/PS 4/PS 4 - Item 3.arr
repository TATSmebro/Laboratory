data NonEmptyTree<T>:
    | node(value :: T, children :: List<NonEmptyTree<T>>)
end

data Tree<T>:
    | empty-tree
    | nonempty-tree(tree :: NonEmptyTree<T>)
end

fun max-of-opt-nums(ls :: List<Option<Number>>):
    cases (List) ls:
        |empty => none
        |link(first, rest) =>
        cases (Option) first:
            |none => max-of-opt-nums(rest)
            |some(val) => 
            cases (Option) max-of-opt-nums(rest):
                |none => some(val)
                |some(value) => some(num-max(val, value))
            end
        end
    end
end

fun deepest(orig-tree :: Tree<String>, string :: String) -> Option<Number>:
    fun deepest-helper(tree :: NonEmptyTree, level :: Number) -> Option<Number>:
        if tree.value == string:
            max-of-opt-nums([list:some(level), max-of-opt-nums(tree.children.map(deepest-helper(_, (level + 1))))])
        else:
            max-of-opt-nums(tree.children.map(deepest-helper(_, (level + 1))))
        end
    end

    cases (Tree) orig-tree:
        |empty-tree => none
        |nonempty-tree(nonemp) => deepest-helper(nonemp, 0)
    end
end