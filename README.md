# snake-fpga-repo


About the game:

Snake is a video game first released during the mid 1970s in arcades and has maintained popularity since then, becoming something of a classic. After it became the standard pre-loaded game on Nokia phones in 1998, Snake found a massive audience.

The player controls a long, thin creature, resembling a snake, which roams around on a bordered plane, picking up food, trying to avoid hitting its own tail or the "walls" that surround the playing area. Each time the snake eats a piece of food, its tail grows longer, making the game increasingly difficult. The user controls the direction of the snake's head (up, down, left, or right), and the snake's body follows. The player cannot stop the snake from moving while the game is in progress, and cannot make the snake go in reverse. 


How to start:

1. download the repository with : git clone https://github.com/thomasczech/snake-fpga-repo.git
2. upload the snake.bit file with XILINX IMPACT tool to your Spartan-3A DSP 1800A fpga-board
3. enjoy the game 

Button-mapping:

SW4 := change the game mode (1. without border, 2. with border, 3. KIT)

SW5 := left

SW6 := up

SW7 := down

SW8 := right
