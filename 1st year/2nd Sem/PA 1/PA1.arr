include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets
import math as M

#Aux
fun remove-foreign(full-table :: Table) -> Table:
    doc: 'removes foreign region from given table'

    fun is-domestic(row :: Row) -> Boolean:
        row['region'] <> 'OAV'
    end

    filter-with(full-table, is-domestic)
end

fun make-list-of-area(table :: Table, area :: String) -> List<String>:
    doc: 'makes a distinct list of all continents or province depending on area requested'
    
    fun not-oav(str :: String) -> Boolean:
        str <> 'OAV'
    end

    if area == 'country':
        sort(distinct(table.get-column('municipality')))
    else if (area == 'province') or (area == 'continent'):
        sort(distinct(table.get-column('province')))
    else if area == 'local-region':
        filter(not-oav, sort(distinct(table.get-column('region'))))
    else if area == 'region':
        sort(distinct(table.get-column('region')))
    end
end

fun isolate-oav(table :: Table) -> Table:
    fun is-oav(row :: Row) -> Boolean:
        row['region'] == 'OAV'
    end

    filter-with(table, is-oav)
end

#Item 1A
fun overseas-vote-tally(table :: Table) -> Table:
    #filter table to only include rows with overseas precincts
    fun is-overseas(row :: Row) -> Boolean:
        row['region'] == 'OAV'
    end

    overseas-table = filter-with(table, is-overseas)

    #create new table with candidate column and number of votes column
    overseas-tally = 
        table: candidate :: String, votes :: Number
            row: 'cayetano', sum(overseas-table, 'cayetano')
            row: 'escudero', sum(overseas-table, 'escudero')
            row: 'honasan', sum(overseas-table, 'honasan')
            row: 'marcos', sum(overseas-table, 'marcos')
            row: 'robredo', sum(overseas-table, 'robredo')
            row: 'trillanes', sum(overseas-table, 'trillanes')
        end
    
    overseas-tally

    where:
        sample = 
            table: region, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: 'OAV', 10, 11, 12, 13, 14, 15
                row: 'NCR', 15, 14, 13, 12, 11, 10
                row: 'OAV', 1, 2, 3, 4, 5, 6
            end

        sample_result = 
            table: candidate, votes
                row: 'cayetano', 11
                row: 'escudero', 13
                row: 'honasan', 15
                row: 'marcos', 17
                row: 'robredo', 19
                row: 'trillanes', 21
            end

        sample2 = 
            table: region, cayetano, escudero, honasan, marcos, robredo, trillanes
                row: 'OAV', 10, 11, 12, 13, 14, 15
                row: 'OAV', 15, 14, 13, 12, 11, 10
                row: 'OAV', 1, 2, 3, 4, 5, 6
            end

        sample_result2 = 
            table: candidate, votes
                row: 'cayetano', 26
                row: 'escudero', 27
                row: 'honasan', 28
                row: 'marcos', 29
                row: 'robredo', 30
                row: 'trillanes', 31
            end
        
        overseas-vote-tally(sample) is sample_result
        overseas-vote-tally(sample2) is sample_result2
end

#Item 1B
fun overseas-votes-as-pie-chart(tally :: Table):
    column-names = tally.row-n(0).get-column-names()
    pie-chart(tally, column-names.get(0), column-names.get(1))
end

#Item 2A
fun domestic-voter-turnout-per-region(table :: Table) -> List<Table>:
    doc: 'returns the voter turnout of each domestic region (except OAV)'
    
    local-region = make-list-of-area(table, 'local-region')

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

#Item 2B
fun domestic-voter-turnout-per-continent(table :: Table) -> List<Table>:
    doc: 'returns the voter turnout of each continent'
    overseas-votes = isolate-oav(table)
    list-of-continents = make-list-of-area(overseas-votes, 'continent')

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

#Item 2C
fun domestic-voter-turnout-per-country(table :: Table) -> List<Table>:
    doc: 'returns the voter turnout of each foreign country'
    overseas-votes = isolate-oav(table)
    list-of-countries = make-list-of-area(overseas-votes, 'country')

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

#Item 3A
fun dominated-domestic-provinces(table :: Table, candidate :: String) -> List<String>:
    doc: 'returns list of dominated provinces by given candidate'

    domestic-region-table = remove-foreign(table)
    desired-columns = [list: 'province', 'cayetano', 'escudero', 'honasan', 'marcos', 'robredo', 'trillanes']
    province-voter-table = select-columns(domestic-region-table, desired-columns)
    list-of-provinces = make-list-of-area(province-voter-table, 'province')

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

#Item 3B
fun domestic-regions-won-by(table :: Table, candidate :: String) -> List<String>:
    doc: 'returns list of regions won by given candidate'

    domestic-region-table = remove-foreign(table)
    desired-columns = [list: 'region', 'cayetano', 'escudero', 'honasan', 'marcos', 'robredo', 'trillanes']
    region-voter-table = select-columns(domestic-region-table, desired-columns)
    list-of-region = make-list-of-area(region-voter-table, 'region')

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