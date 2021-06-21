//Coursework 1 - Zhenghui Wang zw2520
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.4.24;
/**
 * @title TicTacToe contract
 **/
contract TicTacToe {
    address[2] public players;

    /**
     turn
     1 - players[0]'s turn
     2 - players[1]'s turn
     */
    uint public turn = 1;

    /**
     status
     0 - ongoing
     1 - players[0] won
     2 - players[1] won
     3 - draw
     */
    uint public status;

    /**
    board status
     0    1    2
     3    4    5
     6    7    8
     */
    uint[9] private board;

    /**
      * @dev Deploy the contract to create a new game
      * @param opponent The address of player2
      **/
    constructor(address opponent) public {
        require(msg.sender != opponent, "No self play");
        players = [msg.sender, opponent];
    }

    /**
      * @dev Check a, b, c in a line are the same
      * _threeInALine doesn't check if a, b, c are in a line
      * @param a position a
      * @param b position b
      * @param c position c
      **/    
    function _threeInALine(uint a, uint b, uint c) private view returns (bool){
        /*Please complete the code here.*/
        if(board[a]==0 || board[b]==0 || board[c]==0) return false;
        if (board[a]==board[b] && board[b] == board[c]){
            return true;
        } 
        return false;
    }

    /**
     * @dev get the status of the game
     * @param pos the position the player places at
     * @return the status of the game
     */
    function _getStatus(uint pos) private view returns (uint) {
        /*Please complete the code here.*/
        uint hori_pos = pos % 3;
        uint ver_pos = pos / 3;
        // check the horizantal line of "pos" placed the same maker
        if (_threeInALine(hori_pos,hori_pos+3,hori_pos+6)){
            return board[pos];
        // check the vertical line of "pos" placed the same maker
        }else if(_threeInALine(ver_pos*3,ver_pos*3+1,ver_pos*3+2)){
            return board[pos];
        }

        // check the diagonal line of "pos" placed the same maker
        if(pos == 0 || pos == 4 || pos == 8){
           if (_threeInALine(0,4,8)){
                return board[pos];
            }
        }
        if(pos == 2 || pos == 4 || pos == 6){
           if (_threeInALine(2,4,6)){
                return board[pos];
            }
        }

        //return 0 when no winner & the board is not full
        for(uint i =0; i< 9; i++){
            if(board[i]!= 1 && board[i]!= 2){
                return 0;
            }
        }
        // no winner & board is full, return 3(draw)
        return 3;
    }

    /**
     * @dev ensure the game is still ongoing before a player moving
     * update the status of the game after a player moving
     * @param pos the position the player places at
     */
    modifier _checkStatus(uint pos) {
        /*Please complete the code here.*/
        //check the status is ongoing, default value of uint is 0
        require(status== 0);
        _;
        //update status
        status = _getStatus(pos);
    }

    /**
     * @dev check if it's msg.sender's turn
     * @return true if it's msg.sender's turn otherwise false
     */
    function myTurn() public view returns (bool) {
        /*Please complete the code here.*/
        if( msg.sender ==  players[turn-1]){
            return true;
        }
        return false;
    }

    /**
     * @dev ensure it's a msg.sender's turn
     * update the turn after a move
     */
    modifier _myTurn() {
        /*Please complete the code here.*/
        require(msg.sender == players[turn-1]);
        _;
        //update turn
        if(turn == 1){
            turn = 2;
        }else{
            turn = 1;
        }
    }

    /**
     * @dev check a move is valid
     * @param pos the position the player places at
     * @return true if valid otherwise false
     */
    function validMove(uint pos) public view returns (bool) {
      /*Please complete the code here.*/
        if(board[pos] == 1 || board[pos] == 2){
            return false;
        }
        return true;
    }

    /**
     * @dev ensure a move is valid
     * @param pos the position the player places at
     */
    modifier _validMove(uint pos) {
        /*Please complete the code here.*/
        require( pos >= 0);
        require( pos < 9);
        require(board[pos] != 1);
        require(board[pos] != 2);
        _;
    }

    /**
     * @dev a player makes a move
     * @param pos the position the player places at
     */  
    function move(uint pos) public _validMove(pos) _checkStatus(pos) _myTurn {
        board[pos] = turn;
    }

    /**
     * @dev show the current board
     * @return board
     */
    function showBoard() public view returns (uint[9]) {
        return board;
    }
}
