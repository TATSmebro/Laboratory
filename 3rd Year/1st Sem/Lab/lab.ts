export function computeScore(nums: number[]): number {
    let score = 0;
    
    nums.sort();

    if(nums.length !== 0){
        for(let i = 0; i < nums.length - 1; i++){
            if(nums[i] + 1 !== nums[i + 1]){
                score += nums[i + 1];
            }
        }
        
        score += nums[0]
    }

    return score;
}
