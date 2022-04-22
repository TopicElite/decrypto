# decrypto
ATM Hacking with Minigame for ESX Framework

Preview: https://tj-s.online/content/GTAV/decrypto.mp4

## Add items into Database

```sql
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES 
('hackcard', 'Hacking Card', '1', '0', '1'), 
('decryptor', 'Decrypt-o-matic', '1', '0', '1');
```

## Add images to your inventory

- hackcard.png
- decryptomatic.png

## The Minigame
The minigame is based on Matermind
https://en.wikipedia.org/wiki/Mastermind_(board_game)

## Clues
Based on the guess made, clues are given as follows
| Clue | Character | Meaning |
|:---:| --- | --- |
|  | *none* | incorrect character, incorrect position |
| * | asterisk | correct character, incorrect position |
| ! | exclamation point | correct character, correct position |

Each character may only generate **one** clue, with priority given to ! over *

The clue is always ordered with ! before * and does not indicate which characters in your guess corresponds to the clue

Example:
| PIN | Guess | Clue |
|---| --- | --- |
| 5543 | 8765 | * |
| 5543 | 5678 | ! |
| 5543 | 5658 | !* |

The minigame can be set to base 10 (digits 0 through 9) or base 16 (digits 0 through 9 and letters A through F) in the config file.

## Why does the minigame have such a long intro?

I did this to balance Police response versus hacking sprees. You can always modify this in the script.js file (the variable is *message* and has some instructions in the preceeding comment).
