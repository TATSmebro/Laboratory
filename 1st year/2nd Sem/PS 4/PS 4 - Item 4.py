from __future__ import annotations
from dataclasses import dataclass
import random
from timeit import default_timer as timer
from typing import Optional
import uuid


@dataclass
class EmployeeBinTree:
    name: str
    count: int
    left: Optional[EmployeeBinTree]
    right: Optional[EmployeeBinTree]


def new_node():
    return EmployeeBinTree(
        name=str(uuid.uuid4()),        # `str(uuid.uuid4())` returns a (practically) unique string
        count=random.randint(0, 100),
        left=None,
        right=None,
    )


# Take note of what this function does and how it was implemented
def generate(limit: int):
    def helper(cur: EmployeeBinTree, level: int):
        if level <= limit:
            cur.left = helper(new_node(), level + 1)
            cur.right = helper(new_node(), level + 1)

        return cur

    return helper(new_node(), 0)


# Take note of what this function does and how it was implemented
def to_code(node: Optional[EmployeeBinTree]):
    return f"EmployeeBinTree('{node.name}', {node.count}, {to_code(node.left)}, {to_code(node.right)})" if node else 'None'


# Your code here
inv = {}
def invite(tree):
    if tree:
        if tree.name in inv:
            return inv[tree.name]

        with_root = invite_with_root(tree)
        without_root = invite_without_root(tree)
        ret = max(with_root, without_root)
        
        inv[tree.name] = ret

        return ret
    return 0

def invite_with_root(tree):
    if tree:
        return tree.count + invite_without_root(tree.left) + invite_without_root(tree.right)
    return 0

def invite_without_root(tree):
    if tree:
        return invite(tree.left) + invite(tree.right)
    return 0

def main():
    limit = 12

    tree = generate(limit)
    #print(to_code(tree))        # You might want to comment this out for faster execution
    start = timer()
    answer = invite(tree)
    end = timer()
    print(end - start, answer)  # Output is in seconds


if __name__ == '__main__':
    main()