include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets

election-data = 
    load-table: region, province, municipality, barangay, clustered-precinct, cayetano, escudero, honasan, marcos, robredo, trillanes, registered-voters, ballots-cast, precincts, polling-center, timestamp
        source: load-spreadsheet('1gyiLCdwQBdw921-HbDqdxX7WcMWAGvkzDV5XKFjmzro').sheet-by-name("Data", true)
    end

fun remove-foreign(full-table :: Table) -> Table:
    doc: 'removes foreign region from given table'

    fun is-domestic(row :: Row) -> Boolean:
        row['region'] <> 'OAV'
    end

    filter-with(full-table, is-domestic)
end

fun make-list-of-provinces(filtered-table :: Table) -> List<String>:
    doc: 'creates a distinct list of provinces given a table'

    sort(distinct(filtered-table.get-column('province')))
end

fun dominated-domestic-provinces(table :: Table, candidate :: String) -> List<String>:
    doc: 'returns list of dominated provinces by given candidate'

    domestic-region-table = remove-foreign(table)
    desired-columns = [list: 'province', 'cayetano', 'escudero', 'honasan', 'marcos', 'robredo', 'trillanes']
    province-voter-table = select-columns(domestic-region-table, desired-columns)
    list-of-provinces = make-list-of-provinces(province-voter-table)

    fun data-each-province(tbl :: Table) -> List<Table>:
        doc: 'returns a list of table wherein each province is isolated'

        fun isolate-province(province :: String) -> Table:
            fun is-same-province(row :: Row) -> Boolean:
                row['province'] == province
            end

            filter-with(tbl, is-same-province)
        end

        fun transform-table(province-table :: Table) -> Table:
            province = province-table.row-n(0)['province']
            cayetano-total = sum(province-table, 'cayetano')
            escudero-total = sum(province-table, 'escudero')
            honasan-total = sum(province-table, 'honasan')
            marcos-total = sum(province-table, 'marcos')
            robredo-total = sum(province-table, 'robredo')
            trillanes-total = sum(province-table, 'trillanes') 

            table: province, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: province, cayetano-total, escudero-total, honasan-total, marcos-total, robredo-total, trillanes-total
            end
        end

        fun add-total-votes-column(table-of-votes :: Table) -> Table:
            fun total-votes-builder(row :: Row) -> Number:
                row['cayetano'] + row['escudero'] + row['honasan'] + row['marcos'] + row['robredo'] + row['trillanes']
            end

            build-column(table-of-votes, 'total-votes', total-votes-builder)
        end

        list-of-provinces.map(isolate-province).map(transform-table).map(add-total-votes-column)
    end

    fun vote-check(total-votes-table :: Table) -> Boolean:
        half-of-votes = total-votes-table.row-n(0)['total-votes'] / 2
        total-votes-table.row-n(0)[candidate] > half-of-votes
    end

    fun table-to-string(processed-table :: Table) -> String:
        processed-table.row-n(0)['province']
    end

    filter(vote-check, data-each-province(domestic-region-table)).map(table-to-string)

    where:
        sample1 =
            table: region, province, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: 'Region 1', 'Province 1', 1, 2, 3, 4, 20, 6
                row: 'Region 2', 'Province 2', 1, 2, 3, 4, 5, 6
                row: 'OAV', 'Area 1', 1, 2, 3, 4, 20, 6
                row: 'OAV', 'Area 2', 1, 2, 3, 4, 5, 6
            end
        
        sample1-result = [list: 'Province 1']
        
        sample2 =
            table: region, province, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: 'Region 1', 'Province 1', 1, 2, 3, 4, 5, 6
                row: 'Region 2', 'Province 2', 1, 2, 3, 4, 5, 6
                row: 'OAV', 'Area 1', 1, 2, 3, 4, 5, 6
                row: 'OAV', 'Area 2', 1, 2, 3, 4, 5, 6
            end
        
        sample2-result = [list:]

        dominated-domestic-provinces(sample1, 'robredo') is sample1-result
        dominated-domestic-provinces(sample2, 'robredo') is sample2-result

end

dominated-domestic-provinces(election-data, 'robredo')