include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")

human-age :: Table, String -> Number

fun human-age(t, dog-name):
    list-of-names = t.get-column('name')
  
    if list-of-names.member(dog-name):
    
        fun is-same-dog(row :: Row) -> Boolean:
            row['name'] == dog-name
        end

        isolated-table = filter-with(t, is-same-dog)
        age = isolated-table.row-n(0)['age']

        if age == 1:
            15
        else if age == 2:
            24
        else:
      24 + ((age - 2) * 4)
        end

    else:
        0
    end
end
