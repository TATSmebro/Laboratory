include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets
import math as M

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

fun make-list-of-region(filtered-table :: Table) -> List<String>:
    doc: 'creates a distinct list of regions given a table'

    sort(distinct(filtered-table.get-column('region')))
end

fun domestic-regions-won-by(table :: Table, candidate :: String) -> List<String>:
    doc: 'returns list of regions won by given candidate'

    domestic-region-table = remove-foreign(table)
    desired-columns = [list: 'region', 'cayetano', 'escudero', 'honasan', 'marcos', 'robredo', 'trillanes']
    region-voter-table = select-columns(domestic-region-table, desired-columns)
    list-of-region = make-list-of-region(region-voter-table)

    fun data-each-region(tbl :: Table) -> List<Table>:
        doc: 'returns a list of table wherein each region is isolated'

        fun isolate-region(region :: String) -> Table:
            fun is-same-region(row :: Row) -> Boolean:
                row['region'] == region
            end

            filter-with(tbl, is-same-region)
        end

        fun transform-table(region-table :: Table) -> Table:
            region = region-table.row-n(0)['region']
            cayetano-total = sum(region-table, 'cayetano')
            escudero-total = sum(region-table, 'escudero')
            honasan-total = sum(region-table, 'honasan')
            marcos-total = sum(region-table, 'marcos')
            robredo-total = sum(region-table, 'robredo')
            trillanes-total = sum(region-table, 'trillanes') 

            table: region, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: region, cayetano-total, escudero-total, honasan-total, marcos-total, robredo-total, trillanes-total
            end
        end

        list-of-region.map(isolate-region).map(transform-table)
    end

    fun vote-check(total-region-votes-table :: Table) -> Boolean:
        row = total-region-votes-table.row-n(0)
        vote-quantity-per-candidate = [list: row['cayetano'], row['escudero'], row['honasan'], row['marcos'], row['robredo'], row['trillanes']]
        M.max(vote-quantity-per-candidate) == row[candidate]
    end

    fun table-to-string(processed-table :: Table) -> String:
        processed-table.row-n(0)['region']
    end

    filter(vote-check, data-each-region(domestic-region-table)).map(table-to-string)

    where:
        sample1 =
            table: region, province, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: 'Region 1', 'Province 1', 1, 2, 3, 4, 20, 6
                row: 'Region 2', 'Province 2', 1, 2, 3, 4, 5, 6
                row: 'OAV', 'Area 1', 1, 2, 3, 4, 20, 6
                row: 'OAV', 'Area 2', 1, 2, 3, 4, 5, 6
            end
        
        sample1-result = [list: 'Region 1']
        
        sample2 =
            table: region, province, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: 'Region 1', 'Province 1', 1, 2, 3, 4, 7, 6
                row: 'Region 1', 'Province 2', 1, 2, 3, 4, 7, 6
                row: 'Region 2', 'Province 2', 1, 2, 3, 4, 7, 6
                row: 'OAV', 'Area 1', 1, 2, 3, 4, 5, 6
                row: 'OAV', 'Area 2', 1, 2, 3, 4, 5, 6
            end
        
        sample2-result = [list: 'Region 1', 'Region 2']

        domestic-regions-won-by(sample1, 'robredo') is sample1-result
        domestic-regions-won-by(sample2, 'robredo') is sample2-result

end

domestic-regions-won-by(election-data, 'robredo')