# Implementation Plan for Issue #2: High Score Persistence

## Issue Summary
Implement high score persistence with:
1. Best score tracking (lowest number of moves)
2. Display best score in UI
3. Track and display running total of all games played

## Current State Analysis
- The game tracks current moves in state
- Game completion triggers a win modal showing the number of moves
- No persistence mechanism currently exists
- Stats are displayed during gameplay showing current moves and matches

## Implementation Plan

### 1. Add localStorage Helper Functions
Create utility functions to:
- Load best score from localStorage (default to null if not set)
- Save best score to localStorage
- Load total games played from localStorage (default to 0)
- Increment and save total games played

### 2. Add State Variables
Add the following state to the MemoryGame component:
- `bestScore`: number | null - tracks the best (lowest) score
- `totalGamesPlayed`: number - tracks total number of games completed

### 3. Initialize State from localStorage
In a useEffect hook on component mount:
- Load bestScore from localStorage
- Load totalGamesPlayed from localStorage
- Set initial state values

### 4. Update Best Score on Game Win
In the game win logic:
- Check if current moves is less than bestScore (or if bestScore is null)
- If yes, update bestScore state and save to localStorage
- Increment totalGamesPlayed and save to localStorage

### 5. Update UI to Display Stats
Modify the stats section to show:
- Current moves (existing)
- Best score: "Best: X moves" or "Best: --" if no games completed
- Total games played: "Games: X"
- Matches (existing)

### 6. Update Win Modal
Enhance the win modal to show:
- Current completion moves (existing)
- Whether it's a new best score (if applicable)
- Total games played

## Technical Details

### localStorage Keys
- `memoryGameBestScore`: stores the best (lowest) score
- `memoryGameTotalPlays`: stores total games completed

### Logic Flow
1. Game starts → load stats from localStorage
2. During game → display current stats including best score and total games
3. Game won → compare current score to best score
4. If new best → update localStorage and state
5. Always increment total games played on win
6. Display updated stats in win modal

## Files to Modify
- `src/App.jsx` - main game component

## Testing Checklist
- [ ] Best score is saved and persists across page reloads
- [ ] Best score only updates when a lower score is achieved
- [ ] Total games played increments on each win
- [ ] Stats display correctly in the game UI
- [ ] Win modal shows if it's a new best score
- [ ] localStorage data persists between sessions
