# Implementation Plan: Countdown Timer (Issue #4)

## Overview
Add a 60-second countdown timer to the Memory Card Game. If the timer reaches 0, the player loses and is returned to the start screen with a loss notification.

## Issue Details
- **Issue**: #4
- **Title**: Add countdown timer
- **Description**: Add a countdown timer to start at 60 seconds. If the timer reaches 0 (zero), create a lose detection, notify the user they did not complete the game in time and return to the start screen.

## Current State Analysis
The game currently has:
- Win detection when all pairs are matched
- Move counter
- Game start/reset functionality
- Win modal with celebration message

## Implementation Steps

### 1. Add Timer State
- Add `timeRemaining` state variable (initialize to 60)
- Add `timerActive` state variable to control timer execution

### 2. Implement Timer Logic
- Create a `useEffect` hook that:
  - Starts timer when game begins (`gameStarted === true`)
  - Decrements `timeRemaining` every second using `setInterval`
  - Stops when game is won (`gameWon === true`)
  - Stops when timer reaches 0
  - Cleans up interval on unmount or when dependencies change

### 3. Add Loss Detection
- When `timeRemaining` reaches 0:
  - Set a new state variable `gameLost` to `true`
  - Stop the timer
  - Display loss modal

### 4. Create Loss Modal
- Similar structure to the win modal
- Display message: "Time's Up! ⏰"
- Show moves made before time ran out
- Button to return to start screen (reset all game state)

### 5. Display Timer in UI
- Add timer display in the stats section (next to Moves and Matches)
- Format: "Time: XXs"
- Style to match existing stats

### 6. Update Game Reset Logic
- When `initializeGame()` is called:
  - Reset `timeRemaining` to 60
  - Reset `gameLost` to false
  - Restart timer

### 7. Handle Edge Cases
- Prevent card clicks when `gameLost` is true
- Ensure timer stops immediately when game is won
- Clean up timer interval properly to prevent memory leaks

## Files to Modify
- `/home/coder/repo/src/App.jsx` - Main game component

## Testing Plan
1. Start game and verify timer counts down from 60
2. Complete game successfully and verify timer stops
3. Let timer reach 0 and verify:
   - Loss modal appears
   - Appropriate message is shown
   - Return to start screen works
4. Reset game mid-timer and verify timer restarts at 60
5. Verify no memory leaks from timer intervals

## Acceptance Criteria
✅ Timer starts at 60 seconds when game begins
✅ Timer counts down by 1 every second
✅ Timer displays in format "Time: XXs" in stats area
✅ Timer stops when game is won
✅ Timer stops when it reaches 0
✅ Loss modal appears when timer reaches 0
✅ Loss modal shows appropriate "time's up" message
✅ Player can return to start screen from loss modal
✅ Timer resets to 60 when game is reset
