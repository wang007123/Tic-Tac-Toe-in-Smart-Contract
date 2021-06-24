Thanks for the guidence from Dr. Arthur Gervais.  

# COMP70017-CW2
the entire code was packaged into a docker container, no need to configure anything.

## Instructions
1. contract is in the `contracts/TicTacToe.sol`.
2. Build the tic-tac-toe docker image by command  `docker build -t tic-tac-toe .`
3. simply test of this TicTacToe game: `docker run tic-tac-toe npm test` 

# Prerequisite: 

please [install docker](https://docs.docker.com/desktop/) on your system.

To set up and play your tic-tac-toe game, you can:

1. start the ganache test chain

`docker run -p 8545:8545 -d trufflesuite/ganache-cli:latest -g 0`

2. start the web server

`docker run -p 8080:8080 -d tic-tac-toe`

3. open `http://localhost:8080/` in two separate web browsers with each a separate Metamask installed, and enjoy the game. On Chrome you can create **two different users** and install Metamask in each. You'll need to configure Metamask to connect to your local chain as well (which is not graded but we leave this up to you as part of the exercise for your own testing).






