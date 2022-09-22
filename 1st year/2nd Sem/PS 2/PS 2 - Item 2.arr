fun intersperse(lst :: List, sep :: Any) -> List:
  cases (List) lst:
    |empty => lst
    |link(first, rest) =>
      cases (List) rest:
        |empty => link(first, rest)
        |link(rest-first, rest-rest) => link(first, link(sep, intersperse(rest, sep)))
      end
  end
end