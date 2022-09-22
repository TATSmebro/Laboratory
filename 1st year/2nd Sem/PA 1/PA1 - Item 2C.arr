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

fun make-list-of-countries(table :: Table) -> List<String>:
    doc: 'makes a distinct list of all countries'
    sort(distinct(table.get-column('municipality')))
end

fun domestic-voter-turnout-per-country(table :: Table) -> List<Table>:
    doc: 'returns the voter turnout of each foreign country'
    overseas-votes = isolate-oav(table)
    list-of-countries = make-list-of-countries(overseas-votes)

    fun isolate-country(country :: String) -> Table:
        doc: 'returns table with matching municipality'
        
        fun is-same-country(row :: Row) -> Boolean:
            row['municipality'] == country
        end

        filter-with(overseas-votes, is-same-country)
    end

    fun construct-voter-turnout-table(country-tbl :: Table) -> Table:
        country = country-tbl.row-n(0)['municipality']
        voter-turnout = sum(country-tbl, 'ballots-cast') / sum(country-tbl, 'registered-voters')
        
        table: area, turnout
            row: country, voter-turnout
        end 
    end

    list-of-countries.map(isolate-country).map(construct-voter-turnout-table)

    where:
        sample1 =
            table: region, municipality, registered-voters, ballots-cast
                row: 'Region 1', 'Municipality 1', 10, 5
                row: 'Region 2', 'Municipality 2', 20, 8
                row: 'OAV', 'Country 1', 10, 5
                row: 'OAV', 'Country 2', 20, 5
            end

        sample1-result1 =
            table: area, turnout
                row: 'Country 1', 5/10
            end
        
        sample1-result2 =
            table: area, turnout
                row: 'Country 2', 5/20
            end
        
        sample1-result = [list: sample1-result1, sample1-result2]
        
        sample2 =
            table: region, municipality, registered-voters, ballots-cast
                row: 'Region 1', 'Municipality 1', 10, 5
                row: 'Region 2', 'Municipality 2', 20, 8
            end

        sample2-result = [list:]

        domestic-voter-turnout-per-country(sample1) is sample1-result
        domestic-voter-turnout-per-country(sample2) is sample2-result

end

domestic-voter-turnout-per-country(election-data)