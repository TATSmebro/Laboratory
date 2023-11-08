//Marcus Corso S. Pilapil, Stephen Rome E. Pangilinan
import { describe, expect, it } from 'vitest';
import { MultiplicationGame } from './activity';

describe("MultiplicationGame#computeWinner", () => {
    it("detect game-end and winner", () => {
  
      const k: number = 150;
  
      const game = new MultiplicationGame(3, 100, k, 3);
      expect(game.computeWinner()).toBe(2);
  
    });
    
    it("cycles turn and multiplies k", () => {
  
      const k: number = 2;
      const game = new MultiplicationGame(3, 100, k, 2);
      game.playerTurn(3)
      expect(game.currentPlayer).toBe(3);
      expect(game.k).toBe(6);
  
    });
    
    it("cycles from player 5 to 1", () => {
  
      const k: number = 2;
      const game = new MultiplicationGame(5, 100, k, 5);
      game.playerTurn(3)
      expect(game.currentPlayer).toBe(1);
  
    });
    
    it("initializes correctly with given parameters", () => {
  
      const k: number = 5;
      const game = new MultiplicationGame(5, 100, k, 3);
      expect(game.currentPlayer).toBe(3);
      expect(game.k).toBe(5);
  
    });
    
    it("initializes correctly with default parameters", () => {
  
      const game = new MultiplicationGame(5, 100);
      expect(game.currentPlayer).toBe(1);
      expect(game.k).toBe(2);
  
    });
});