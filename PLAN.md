# Implementation Plan: High Score Persistence (Issue #2)

## Overview
Implement high score persistence for the Memory Card Game. This will track the best score (lowest number of moves), display it in the UI, and add a running total of all games played.

## Requirements
1. Persist high score (best/lowest number of moves) across sessions
2. Display best score in the UI
3. Track and display total number of games played

## Technical Approach

### 1. Data Structure (localStorage)
Store game statistics in localStorage with the following structure:
```javascript
{
  bestScore: number | null,  // Lowest number of moves (null if no games completed)
  totalGamesPlayed: number   // Total number of completed games
}
```

### 2. Implementation Steps

#### Step 1: Create localStorage utility functions
- `loadStats()`: Load statistics from localStorage
- `saveStats(stats)`: Save statistics to localStorage
- Handle cases where localStorage is not available or empty

#### Step 2: Add state management
Add new state variables in the MemoryGame component:
- `bestScore`: Track the best score
- `totalGamesPlayed`: Track total completed games

#### Step 3: Load stats on component mount
Use `useEffect` to load stats from localStorage when component mounts

#### Step 4: Update stats when game is won
- Increment `totalGamesPlayed` counter
- Update `bestScore` if current score is better (lower) than previous best
- Save to localStorage
- This happens in the win detection logic (around line 53-54)

#### Step 5: Update UI to display stats
Add statistics display in the header/stats section:
- Show "Best: X moves" (or "Best: --" if no games completed yet)
- Show "Games Played: X"
- Position near existing "Moves" and "Matches" display

#### Step 6: Update win modal
Display whether player achieved a new best score in the win modal

## Files to Modify
- `src/App.jsx`: Add state, localStorage logic, and UI updates

## Edge Cases to Handle
1. First time player (no localStorage data)
2. localStorage not available (privacy mode)
3. Best score should only update if game is completed (not on reset)
4. Handle localStorage quota exceeded errors

## Testing Checklist
- [ ] Stats load correctly on page refresh
- [ ] Best score updates when player completes game with fewer moves
- [ ] Best score doesn't update when player uses more moves
- [ ] Total games increments on each completed game
- [ ] Stats persist across browser sessions
- [ ] UI displays correctly with and without previous stats
- [ ] Win modal shows "New best!" when appropriate

## UI Design Notes
- Keep consistent with existing purple gradient theme
- Add stats to the existing stats display (line 114-127)
- Make it clear which score is current vs best
- Consider adding celebratory message for new best scores
