data JsonObject:
  | json-null
  | json-bool(bool :: Boolean)
  | json-num(n :: Number)
  | json-str(str :: String)
  | json-list(lst :: List<JsonObject>)
  | json-pairs(pairs :: List<{String; JsonObject}>)
end

fun print-json(json :: JsonObject) -> String:
    fun print-json-list-comma(lst :: List<JsonObject>) -> String:
        cases (List) lst:
            |empty => ']'
            |link(first, rest) => ', ' + print-json(first) + print-json-list-comma(rest)
        end
    end

    fun print-json-pairs-comma(l :: List<{String; JsonObject}>) -> String:
        cases (List) l:
            |empty => '}'
            |link(first, rest) => ', ' + print-json(json-str(first.{0})) + ': ' + print-json(first.{1}) + print-json-pairs-comma(rest)
        end
    end

    cases (JsonObject) json:
        |json-null => 'null'
        |json-bool(bool) => 
        if bool:
            'true'
        else:
            'false'
        end
        |json-num(n) => num-to-string(n)
        |json-str(str) => '"' + str + '"'
        |json-list(ls) =>
        cases (List) ls:
            |empty => '[]'
            |link(first, rest) => '[' + print-json(first) + print-json-list-comma(rest)
        end
        |json-pairs(pairs) =>
        cases (List) pairs:
            |empty => '{}'
            |link(first, rest) => '{' + print-json(json-str(first.{0})) + ': ' + print-json(first.{1}) + print-json-pairs-comma(rest)
        end
    end
end