fun is-prime(n :: Number) -> Boolean:
    fun  is-prime-helper(k :: Number, index :: Number) -> Boolean:
        if index == k:
            true
        else if num-modulo(k, index) == 0:
            false
        else:
            is-prime-helper(k, index + 1)
        end
    end

    is-prime-helper(n, 2)
end