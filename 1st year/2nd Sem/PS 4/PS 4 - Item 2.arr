data CountTree:
  | count-node(count :: Number, children :: List<CountTree>)
end

data NonEmptyTree<T>:
  | node(value :: T, children :: List<NonEmptyTree<T>>)
end

data Tree<T>:
  | empty-tree
  | nonempty-tree(tree :: NonEmptyTree<T>)
end

fun child-count-tree(tree :: Tree) -> Option<CountTree>:
    cases (Tree) tree:
        |empty-tree => None
        |nonempty-tree(nonemp-tree) =>
        cases (NonEmptyTree) nonemp-tree:
            |node(value, children) =>
            some(count-node(length(children), map(child-count-tree, children)))
        end
    end
end

fun child-count-tree(tree :: Tree) -> Option<CountTree>:
    fun count-tree(nd :: NonEmptyTree) -> CountTree:
        cases (NonEmptyTree) nd:
            |node(value, children) =>
            cases (List) children:
                |empty => count-node(0, [list: ])
                |link(first, rest) => count-node(length(children), map(count-tree, children))
            end
        end
    end

    cases (Tree) tree:
        |empty-tree => none
        |nonempty-tree(nonemp-tree) => some(count-tree(nonemp-tree))
    end
end