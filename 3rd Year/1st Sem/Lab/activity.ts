//Marcus Corso S. Pilapil, Stephen Rome E. Pangilinan
export class MultiplicationGame{
    private numberOfPlayers: number;
    private _k: number;
    private n: number;
    private _currentPlayer: number = 1;

    constructor(numberOfPlayers: number, n: number, k: number = 2, currentPlayer: number = 1){
        this.numberOfPlayers = numberOfPlayers;
        this.n = n;
        this._k = k;
        this._currentPlayer = currentPlayer;
    }

    get currentPlayer(){
        return this._currentPlayer;
    }

    get k(){
        return this._k;
    }

    computeWinner(): number | null{
        if(this.n <= this.k){
            if(this.currentPlayer - 1 === 0){
                return this.numberOfPlayers;
            }
            
            return this.currentPlayer - 1;
        }

        return null;
    }

    playerTurn(val: number){
        this._k = this.k * val;
        this._currentPlayer = (this.currentPlayer % this.numberOfPlayers) + 1;
    }
}

function printGameState(game: MultiplicationGame){
    console.log(`k = ${game.k}`)
    console.log(`current player =  ${game.currentPlayer}`)
}

const game = new MultiplicationGame(3, 100, 2);

while(game.computeWinner() === null){
    let turn = Math.floor(Math.random() * 8) + 2
    game.playerTurn(turn)
    console.log(turn);
    printGameState(game);
}

console.log(game.computeWinner());