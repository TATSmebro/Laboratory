export function hey(message: string): string {  
    if(containsNoLetters(message)){
        if(containsOnlyWhiteSpace(message)){
            return "Fine. Be that way!";
        }
        else if(message.charAt(message.trim().length - 1) === '?'){
            return "Sure."
        }
        else{
            return "Whatever.";
        }
    }
    if(message.charAt(message.trim().length - 1) === '?'){
        if(isUpperCase(message)){
            return "Calm down, I know what I'm doing!"; 
        }
        return "Sure.";
    }
    else if(isUpperCase(message)){
        return "Whoa, chill out!"; 
    }
    else{
        return "Whatever.";
    }
}

function isUpperCase(message: string): Boolean {
    if(message === message.toUpperCase()){
        return true;
    }
    else{
        return false;
    }
}

function containsOnlyWhiteSpace(input: string): boolean {
    return /^\s*$/.test(input);
}

function containsNoLetters(input: string): boolean {
    return /^[^A-Za-z]*$/.test(input);
}