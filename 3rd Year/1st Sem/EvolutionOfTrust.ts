import { argv } from 'process';
class evolutionOfTrustGame{
    private N: number;
    private _currentRound: number = 1;
    private _scoreA: number = 0;
    private _scoreB: number = 0;
    
    constructor(N: number){
        this.N = N;
    }

    get scoreA(){
        return this._scoreA;
    }
    
    get scoreB(){
        return this._scoreB;
    }

    get currentRound(){
        return this._currentRound;
    }

    isGameDone(): boolean{
        return this.currentRound > this.N;
    }

    playerTurn(turnA: number, turnB: number){ //1:cooperate 2:cheat
        if(turnA > turnB){
            this._scoreA += 3;
            this._scoreB -= 1;
            console.log('3,-1');
        }else if(turnB > turnA){
            this._scoreB += 3;
            this._scoreA -= 1;
            console.log('-1,3');
        }else if(turnA === 1){
            this._scoreB += 2;
            this._scoreA += 2;
            console.log('2,2');
        }else{
            this._scoreB += 0;
            this._scoreA += 0;            
            console.log('0,0');
        }

        this._currentRound += 1;
    }
}

function generateMove(game: evolutionOfTrustGame, playerType: string, otherPlayerMove: number, cheated: boolean): number{
    if(playerType === 'copycat'){
        if(game.currentRound === 1){
            return 1;
        }else{
            return otherPlayerMove;
        }
    }else if(playerType === 'detective'){
        if(game.currentRound <= 4){
            if(game.currentRound === 2){
                return 2;
            }else{
                return 1;
            }
        }else{
            if(cheated){
                return otherPlayerMove;
            }else{
                return 2;
            }
        } 
    }else{ //player is grudger
        if(cheated){
            return 2;
        }else{
            return 1;
        }
    }
}

let N = parseInt(argv[2]);
let playerA:string = argv[3];
let playerB:string = argv[4];
const movesA: number[] = []
const movesB: number[] = []
let cheatA = movesA.includes(2) ? true : false;
let cheatB = movesB.includes(2) ? true : false;

let game = new evolutionOfTrustGame(N);
let i = 0;

while(!game.isGameDone()){
    if(game.currentRound === 1){
        movesA.push(1);
        movesB.push(1);
        game.playerTurn(1, 1);
    }else{
        let moveA = generateMove(game, playerA, movesB[i - 1], cheatB);
        let moveB = generateMove(game, playerB, movesA[i - 1], cheatA);
        movesA.push(moveA);
        movesB.push(moveB);
        game.playerTurn(moveA, moveB);
    }
    i++;
}

console.log(`${game.scoreA > 0 ? '+' : ''}${game.scoreA} vs. ${game.scoreB > 0 ? '+' : ''}${game.scoreB}`)

/*
1. The first change is the addition of event handlers. Then we would need to change 
majority of the code outside the functions, specifically the global variables. 
We need to wrap them within a class or a function.

2. I need to add this functionality within the generate move function. I just need the return value to flip
at a given rate which is very easy to implement.

3. It is doable but a bit tedious since the sequence of events are hard-coded within the while loop.
*/