from __future__ import annotations        # Without this, you will get a "`BinaryTree` is not defined" error
from dataclasses import dataclass
from typing import Any, Optional, TypeVar, Generic

T = TypeVar('T')  # More on `TypeVar` and `Generic` in CS 150

@dataclass
class BinaryTree(Generic[T]):
    value: T
    left: Optional[BinaryTree[T]]
    right: Optional[BinaryTree[T]]


def fold_tree(node, f, initial):
    if node:
        left_ans = fold_tree(node.left, f, initial)
        right_ans = fold_tree(node.right, f, initial)
        return f(node.value, left_ans, right_ans)
    return initial

def flatten(node):
    ret = []
    if node:
        ret = flatten(node.left)
        ret.append(node.value)
        ret += flatten(node.right)
    return ret


tree = BinaryTree(1, BinaryTree(2, None, None), BinaryTree(3, BinaryTree(4, None, None), None))
emp = None
print(flatten(tree))