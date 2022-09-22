include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets

election-data = 
    load-table: region, province, municipality, barangay, clustered-precinct, cayetano, escudero, honasan, marcos, robredo, trillanes, registered-voters, ballots-cast, precincts, polling-center, timestamp
        source: load-spreadsheet('1gyiLCdwQBdw921-HbDqdxX7WcMWAGvkzDV5XKFjmzro').sheet-by-name("Data", true)
    end

fun make-list-of-local-region(table :: Table) -> List<String>:
    doc: 'makes a distinct list of all local regions from a given table'

    fun not-oav(str :: String) -> Boolean:
        str <> 'OAV'
    end

   filter(not-oav, sort(distinct(table.get-column('region'))))
end

fun domestic-voter-turnout-per-region(table :: Table) -> List<Table>:
    doc: 'returns the voter turnout of each domestic region (except OAV)'
    
    local-region = make-list-of-local-region(table)

    fun isolate-region(region :: String) -> Table:
        doc: 'returns table with matching region'
        
        fun is-same-region(row :: Row) -> Boolean:
            row['region'] == region
        end

        filter-with(table, is-same-region)
    end

    fun construct-voter-turnout-table(region-tbl :: Table) -> Table:
        doc: 'transforms table from isolate-region funciton into a table with a single row'

        region = region-tbl.row-n(0)['region']
        voter-turnout = sum(region-tbl, 'ballots-cast') / sum(region-tbl, 'registered-voters')
        
        table: area, turnout
            row: region, voter-turnout
        end 
    end

    local-region.map(isolate-region).map(construct-voter-turnout-table)

    where:
        sample1 =
            table: region, registered-voters, ballots-cast
                row: 'Region 1', 10, 5
                row: 'Region 2', 20, 8
                row: 'OAV', 10, 5
            end

        sample1-result1 = 
            table: area, turnout
                row: 'Region 1', 5/10
            end

        sample1-result2 = 
            table: area, turnout
                row: 'Region 2', 8/20
            end
        
        
        sample1-result = [list: sample1-result1, sample1-result2]

        sample2 =
            table: region, registered-voters, ballots-cast
                row: 'Region 1', 10, 0
                row: 'Region 2', 20, 20
            end

        sample2-result1 = 
            table: area, turnout
                row: 'Region 1', 0/10
            end

        sample2-result2 = 
            table: area, turnout
                row: 'Region 2', 20/20
            end
        
        
        sample2-result = [list: sample2-result1, sample2-result2]

        domestic-voter-turnout-per-region(sample1) is sample1-result
        domestic-voter-turnout-per-region(sample2) is sample2-result
end

domestic-voter-turnout-per-region(election-data)