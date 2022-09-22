fun group-by(lst :: List<String>, get-group-name :: (String -> String)) -> List<List<String>>:
    fun same-group(str :: String, x :: String) -> Boolean:     
        get-group-name(str) == x
    end

    distinct(lst.map(get-group-name).sort().reverse().map(lam(x): filter(same-group(_, x), lst.sort()) end)).reverse()
end