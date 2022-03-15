include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets

election-data = 
    load-table: region, province, municipality, barangay, clustered-precinct, cayetano, escudero, honasan, marcos, robredo, trillanes, registered-voters, ballots-cast, precincts, polling-center, timestamp
        source: load-spreadsheet('1gyiLCdwQBdw921-HbDqdxX7WcMWAGvkzDV5XKFjmzro').sheet-by-name("Data", true)
    end

fun isolate-oav(table :: Table) -> Table:
    fun is-oav(row :: Row) -> Boolean:
        row['region'] == 'OAV'
    end

    filter-with(table, is-oav)
end

fun make-list-of-continents(table :: Table) -> List<String>:
    doc: 'makes a distinct list of all continents'
    sort(distinct(table.get-column('province')))
end

fun domestic-voter-turnout-per-continent(table :: Table) -> List<Table>:
    doc: 'returns the voter turnout of each continent'
    overseas-votes = isolate-oav(table)
    list-of-continents = make-list-of-continents(overseas-votes)

    fun isolate-continent(continent :: String) -> Table:
        doc: 'returns table with matching continent'
        
        fun is-same-continent(row :: Row) -> Boolean:
            row['province'] == continent
        end

        filter-with(overseas-votes, is-same-continent)
    end

    fun construct-voter-turnout-table(continent-tbl :: Table) -> Table:
        continent = continent-tbl.row-n(0)['province']
        voter-turnout = sum(continent-tbl, 'ballots-cast') / sum(continent-tbl, 'registered-voters')
        
        table: area, turnout
            row: continent, voter-turnout
        end 
    end

    list-of-continents.map(isolate-continent).map(construct-voter-turnout-table)

    where:
        sample1 =
            table: region, province, registered-voters, ballots-cast
                row: 'Region 1', 'Province 1', 10, 5
                row: 'Region 2', 'Province 2', 20, 8
                row: 'OAV', 'Continent 1', 10, 5
                row: 'OAV', 'Continent 2', 20, 5
            end

        sample1-result1 =
            table: area, turnout
                row: 'Continent 1', 5/10
            end
        
        sample1-result2 =
            table: area, turnout
                row: 'Continent 2', 5/20
            end
        
        sample1-result = [list: sample1-result1, sample1-result2]
        
        sample2 =
            table: region, province, registered-voters, ballots-cast
                row: 'Region 1', 'Province 1', 10, 5
                row: 'Region 2', 'Province 2', 20, 8
            end

        sample2-result = [list:]
        
        domestic-voter-turnout-per-continent(sample1) is sample1-result
        domestic-voter-turnout-per-continent(sample2) is sample2-result

end

domestic-voter-turnout-per-continent(election-data)