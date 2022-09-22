fun choose(lst :: List<Option>) -> {List; Number}:
    fun choose-helper(lst-help :: List<Option>, lst-so-far :: List, none-so-far :: Number) -> {List; Number}:
        cases (List) lst-help:
            |empty              => {lst-so-far.reverse(); none-so-far}
            |link(first, rest)  =>
            cases (Option) first:
                |none       => choose-helper(rest, lst-so-far, none-so-far + 1)
                |some(k)    => choose-helper(rest, link(k, lst-so-far), none-so-far)
            end
        end
    end

    choose-helper(lst, [list: ], 0)
end