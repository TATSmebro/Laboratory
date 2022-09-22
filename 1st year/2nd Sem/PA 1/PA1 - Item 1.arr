include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets

vote-data = 
    load-table: region, province, municipality, barangay, clustered-precinct, cayetano, escudero, honasan, marcos, robredo, trillanes, registered-voters, ballots-cast, precincts, polling-center, timestamp
        source: load-spreadsheet('1gyiLCdwQBdw921-HbDqdxX7WcMWAGvkzDV5XKFjmzro').sheet-by-name("Data", true)
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

overseas-votes-as-pie-chart(overseas-vote-tally(vote-data))