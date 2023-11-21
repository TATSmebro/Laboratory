export function isIsogram(word: string): boolean {
    const checked: string[] = [];       
    
    for(var char of cleanString(word)){
        if(checked.includes(char)){
            return false;
        
        }
        else{
            checked.push(char);
        }
    }
    return true;
}

function cleanString(str: string): string{
    return str.trim().toLowerCase().replace(/[-\s]+/g,'');
}