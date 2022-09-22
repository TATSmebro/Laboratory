include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")

number-of-fostered-dogs :: Table, String -> Number

fun number-of-fostered-dogs(t, foster-parent):
    fun is-parent(row :: Row) -> Boolean:
        row['foster-parent'] == foster-parent
    end

    parent-table = filter-with(t, is-parent)
    parent-table.length()
end