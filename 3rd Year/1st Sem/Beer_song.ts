/*
To finish passing the all test cases, it took me about 30-45 mins in total. 
I struggled with figuring out what was wrong. It turns out it was just the new line characters
*/

/*
I tried my best to find anything to simplify or shorten parts of the code and I was able to consume the whole
hour trying to do so.
*/


export function verse(index: number): unknown {
    if(index === 2){
        return '2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n';
    }
    else if(index === 1){
        return '1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n';
    }else if(index === 0){
        return 'No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n';
    }
    else{
        return `${index} bottles of beer on the wall, ${index} bottles of beer.\nTake one down and pass it around, ${index - 1} bottles of beer on the wall.\n`;
    }
}
  
export function sing(initialBottlesCount?: unknown, takeDownCount?: unknown): unknown {
    let start = 99;
    let end = 0;
    let ret = '';

    if(typeof initialBottlesCount === 'number'){
        start = initialBottlesCount;
    }

    if(typeof takeDownCount === 'number'){
        end = takeDownCount;
    }
    
    for(let bottleCount = start; bottleCount >= end; bottleCount--){
        if(bottleCount === end){
            ret += verse(bottleCount);
        }
        else{
            ret += verse(bottleCount) + '\n';
        }
    }

    return ret;
}