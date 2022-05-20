fun burger(n :: Number) -> Image:
    bun = rectangle(60 + (10 * (n - 1)), 15, 'solid', 'navajo-white')
    cheese = rectangle(60 + (10 * (n - 1)), 10, 'solid', 'yellow')
    patty = rectangle(60 + (10 * (n - 1)), 10, 'solid', 'brown')
    lettuce = rectangle(60 + (10 * (n - 1)), 10, 'solid', 'green')

    if n == 1:
        above(bun, above(cheese, above(patty, above(lettuce,bun))))
    else:
        above(bun, above(cheese, above(patty, above(burger(n - 1), above(lettuce, bun)))))
    end
end