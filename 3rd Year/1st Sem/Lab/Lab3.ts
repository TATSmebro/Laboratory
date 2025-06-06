const listOfGE: ReadonlyArray<string> = ['Anthro 10', 'Aral Pil 12', 'Araling Kapampangan 10', 'Archaeo 2', 'Arkiyoloji 1', 'Art Stud 1', 'Art Stud 2', 'ARTS 1', 'BC 10', 'BIO 1', 'CE 10', 'Chem 1', 'Comm 3 Eng', 'Comm 3 Fil', 'CW 10', 'DRMAPS', 'Econ 11', 'Econ 31', 'EEE 10', 'EL 50', 'Eng 1', 'Eng 10', 'Eng 11', 'Eng 12', 'Eng 13', 'Eng 30', 'Env Sci 1', 'ES 10', 'Ethics 1', 'FA 28', 'FA 30', 'Fil 18', 'Fil 18', 'Fil 25', 'Fil 40', 'Film 10', 'Film 12', 'FN 1', 'GE 1', 'Geog 1', 'Geol 1', 'Humad 1', 'Humanidades 1', 'J 18', 'Kas 2', 'Kom 1', 'L Arch 1', 'Lingg 1', 'LIS 10 ', 'Math 1', 'Math 2', 'MBB 1', 'MPs 10', 'MS 1', 'MuD 1', 'MuL 13', 'MuL 9', 'Nat Sci 1', 'Nat Sci 2', 'Pan Pil 12', 'Pan Pil 17', 'Pan Pil 19', 'Pan Pil 40', 'Pan Pil 50', 'Phil Stud 12', 'PHILARTS 1', 'Philo 10', 'Philo 11', 'Physics 10', 'PS 21', 'SAS 1', 'SEA 30', 'Soc Sci 1', 'Soc Sci 2', 'Socio 10', 'SOSC 3', 'Speech 30', 'STS', 'STS 1', 'Theatre 10', 'Theatre 11', 'Theatre 12',]

class Section {
    
    private sectionName: string;
    private weeklySched: number[][]; // list containing 6 number lists pertaining to each day of the week [[start, end], ...]
    private slots: number;

    constructor(sectionName: string, weeklySched: number[][], slots: number){
        this.sectionName = sectionName;
        this.weeklySched = weeklySched;
        this.slots = slots;
    }

    public isGE(): boolean {
        let sectionName = this.sectionName;

        for(let section of listOfGE){
            if(sectionName.includes(section)){
                return true;
            }  
        }

        return false;
    }

    public hasConflict(other: Section): boolean {
        for(let i = 0; i < 6; i++){
            if(this.weeklySched[i].length !== 0 && other.weeklySched[i].length !== 0){
                if((other.weeklySched[i][0] <= this.weeklySched[i][0] && this.weeklySched[i][0] <= other.weeklySched[i][1]) || (this.weeklySched[i][0] <= other.weeklySched[i][0] && other.weeklySched[i][0] <= this.weeklySched[i][1])){
                    return true; 
                }
            }
        }
        
        return false;
    }

    public hasSlots(): boolean {
        return (this.slots > 0);
    }
}

function cleanTime(uncleanTime: string, suffix: 'AM' | 'PM'){
    let timeString = uncleanTime.split(':').join('').replace(/AM|PM/g, '');
    
    if(timeString.length <= 2){
        timeString += '00';
    }

    let timeInt = parseInt(timeString);

    if(suffix === 'PM'){
        if(timeInt < 1200){
            return timeInt + 1200;
        }
    }

    return timeInt;
}

function convertTo24Hour(timeString: string): number[] { //converts 10:30AM-1PM to 24HR format [1030, 100]
    const [start, end] = timeString.split('-');
    const ret: number[] = [];
    
    if(end.includes('AM')){
        ret[0] = cleanTime(start, 'AM');
        ret[1] = cleanTime(end, 'AM');
    }
    else if(start.includes('AM')){
        ret[0] = cleanTime(start, 'AM');
        ret[1] = cleanTime(end, 'PM');
    }
    else{
        ret[0] = cleanTime(start, 'PM');
        ret[1] = cleanTime(end, 'PM');
    }
    
    return ret;
}

function parseWeeklySched(weeklySched: string): number[][]{
    const week: number[][]= [[], [], [], [], [], []]
    const dailySched = weeklySched.split('; ');
    
    for(let sched of dailySched){

        const schedParts = sched.split(' ');
        let timeInt: number[] = convertTo24Hour(schedParts[1]);

        if(schedParts[0].includes('M')){
            week[0] = timeInt;
        }
        if(/T(?!h)/.test(schedParts[0])){
            week[1] = timeInt;
        }
        if(schedParts[0].includes('W')){
            week[2] = timeInt;
        }
        if(schedParts[0].includes('Th')){
            week[3] = timeInt;
        }
        if(schedParts[0].includes('F')){
            week[4] = timeInt;
        }
        if(schedParts[0].includes('S')){
            week[5] = timeInt;
        }
    }

    return week;
}

export function parseInput(input: string): Section[] {

    const ret: Section[] = [];
    const schedules: string[] = input.split('\n');

    for(let sched of schedules){                //Parse each line from input
        let sectionName = sched.split(',')[0];   //Get section name
        let weeklySched = parseWeeklySched(sched.split(',')[1]); //Get weekly schedule
        let newSection = new Section(sectionName, weeklySched, 30); //create new Section class
        ret.push(newSection);                   //Push new Section object to return list
    }

    return ret;
}

export function getHasSlots(sections: Section[]): Section[] {
    return sections.filter((_) => (_.hasSlots()));
}

export function getGEs(sections: Section[]): Section[] {
    return sections.filter((_) => !(_.isGE()));
}

export function getAllWithConflict(sections: Section[]): Section[] {
    return sections.filter((x) => (sections.map((_) => _.hasConflict(x)).filter((_) => _).length) > 1);
}