include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")

get-all-female-dogs :: Table -> List<String>

fun get-all-female-dogs(t):
  fun is-female(row :: Row) -> Boolean:
        row['gender'] == 'F'
  end

  female-dogs-table = filter-with(t, is-female)
  female-dogs = female-dogs-table.get-column('name')
  female-dogs.sort()
end
