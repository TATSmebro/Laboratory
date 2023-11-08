import { describe, expect, it } from 'vitest';
import { computeScore } from './lab';

describe('#computeScore', () => {  // Convention: #<function-name>
    it('works on empty array', () => {
      expect(computeScore([])).toBe(0);
    });
   
    it('works on array with no sequences', () => {
      expect(computeScore([-10, -20, -30])).toBe(-60);
    });
    
    it('works on array with multiple sequences', () => {
      expect(computeScore([5, 6, 1, 3, 2])).toBe(6);
    });
    
    it('works on array with 1 sequence', () => {
      expect(computeScore([5, 4, 1, 3, 2])).toBe(1);
    });
    
    it('works on array with 1 element', () => {
      expect(computeScore([5])).toBe(5);
    });
    
});