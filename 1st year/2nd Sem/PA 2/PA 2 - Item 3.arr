type RebateScheme = {
  cut-per-level :: List,
  min-spent :: Number,
}

type Products = {
  whitening :: Number,
  supplement :: Number,
  lipstick :: Number,
}

data Member:
  | member-info(
      name :: String,
      direct-referrals :: List<Member>,
      bought :: Products,
      sold :: Products
      )
end

type Organization = {
  members :: Member,
  prices :: Products,
  rebate-scheme :: RebateScheme,
}

data Status:
  | rockstar(level :: Number)
  | loser
  | nondescript
end

data LabeledMember:
  | labeled-member-info(
      name :: String,
      direct-referrals :: List<LabeledMember>,
      bought :: Products,
      sold :: Products,
      status :: Status
      )
end

fun in-tree(mem :: Member, name :: String):
    doc: 'Returns the member if name exists in tree and returns none otherwise'
    fun in-tree-helper(lst :: List):
        cases (List) lst:
            |empty => none
            |link(first, rest) =>
            memb = first
            if in-tree(first, name) <> none:
                in-tree(memb, name)
            else:
                in-tree-helper(rest)
            end
        end
    end

    if mem.name == name:
        mem
    else:
        #for each children, in-tree()
        cases (List) mem.direct-referrals:
            |empty => none
            |link(first, rest) =>
            in-tree-helper(mem.direct-referrals)
        end
    end
end

fun compute-total-sales(mem :: Member, org :: Organization) -> Number:
    doc: 'computes total sales of member in org'
    whitening = mem.sold.whitening * (org.prices.whitening * 2)
    supplement = mem.sold.supplement * (org.prices.supplement * 2)        
    lipstick = mem.sold.lipstick * (org.prices.lipstick * 2)
    
    total = whitening + supplement + lipstick
    total
end

fun compute-total-bought(mem :: Member, org :: Organization) -> Number:
    doc: 'computes total bought of member in org'
    whitening = mem.bought.whitening * org.prices.whitening        
    supplement = mem.bought.supplement * org.prices.supplement        
    lipstick = mem.bought.lipstick * org.prices.lipstick
    
    total = whitening + supplement + lipstick
    total
end

fun my-sum(l :: List) -> Number:
    cases (List) l:
        |empty => 0
        |link(first, rest) => first + my-sum(rest)
    end
end

fun compute-rebate(mem :: Member, org :: Organization) -> Number:
    doc: 'computes total rebate of member in org'
    fun compute-rebate-helper(memb :: Member, lvl :: Number):
        child = memb.direct-referrals
        cases (List) child:
            |empty => 0
            |link(first, rest) =>
            if lvl == org.rebate-scheme.cut-per-level.length():
                (my-sum(child.map(compute-total-bought(_, org))) * org.rebate-scheme.cut-per-level.get(lvl - 1))
            else:
                (my-sum(child.map(compute-total-bought(_, org))) * org.rebate-scheme.cut-per-level.get(lvl - 1)) + my-sum(child.map(compute-rebate-helper(_, (lvl + 1))))
            end
        end
    end
    
    if (compute-total-bought(mem, org) < org.rebate-scheme.min-spent) or (org.rebate-scheme.cut-per-level == empty):
        0
    else:
        compute-rebate-helper(mem, 1)
    end
end

fun get-individual-net-profit(org :: Organization, name :: String) -> Option<Number>:
    doc: 'computes net profit of member in org'
    founder = org.members
    mem = in-tree(founder, name)
    
    if mem == none:
        none
    else:
        sales = compute-total-sales(mem, org)
        bought = compute-total-bought(mem, org)
        rebate = compute-rabate(mem, org)
        profit = (sales + rebate) - bought
        some(profit)
    end        
end

fun count-downline(mem :: Member) -> Number:
    dr = mem.direct-referrals
    cases (List) dr:
        |empty => 0
        |link(first, rest) => dr.length() + my-sum(dr.map(count-downline(_))) 
    end
end

fun get-status (mem :: Member, org :: Organization) -> Status:
    profit = get-individual-net-profit(org, mem.name).value
    total-bought = compute-total-bought(mem, org)
    if (profit >= (3 * total-bought)) and (profit > 0):
        level = 1 + num-floor(count-downline(mem) / 10)
        rockstar(level)
    else if profit < total-bought:
        loser
    else
        nondescript
    end
end

fun tag-with-status(org :: Organization) -> LabeledMember:
    fun tag-with-status-helper(mems :: Member) -> LabeledMember:
        cases (List) mems.direct-referrals:
            |empty => labeled-member-info(mems.name, mems.direct-referrals, mems.bought, mems.sold, get-status(mems, org))
            |link(first, rest) => labeled-member-info(mems.name, mems.direct-referrals.map(tag-with-status-helper), mems.bought, mems.sold, get-status(mems, org))
        end
    end

    tag-with-status-helper(org.members)
end

fun get-num-of-loser(labmem :: LabeledMember) -> Number:
    dr = labmem.direct-referrals
    cases (List) dr:
        |empty => 
            if labmem.status == loser:
                1
            else:
                0
            end
        |link(first, rest) => 
            if labmem.status == loser:
                1 + my-sum(dr.map(get-num-of-loser(_))) 
            else:
                0 + my-sum(dr.map(get-num-of-loser(_))) 
            end
    end
end

fun get-losing-status(org :: Organization) -> {Number; Number; Number}:
    labeled-founder = tag-with-status(org)
    num-of-loser = get-num-of-loser(labeled-founder)
    num-of-members = count-downline(org.members) + 1

    {num-of-loser; num-of-members; num-of-loser / num-of-members}
end