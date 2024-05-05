# 0 represents non-poisoned bars and 3 represent the poisoned bar
# 1 will represent P1 and 2 will represent P2 once the game started
import random


def init_game():
    arr = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [3, 0, 0, 0, 0, 0]]
    return arr


def display_game(game):
    symbols = {0: '-', 1: ' ', 2: ' ', 3: '*'}  # Mapping of game state to symbols
    print("  0 1 2 3 4 5")
    for i in range(len(game)):
        print(i, end=' ')
        for j in range(len(game[0])):
            print(symbols[game[i][j]], end=' ')
        print()


def simulate_move(move, arr, player):
    r = move[0]
    c = move[1]
    if arr[r][c] == 0:
        for i in range(0, r + 1):
            for j in range(c, 6):
                arr[i][j] = player
    else:
        print("Invalid move")


def game_over_checker(arr):
    for i in range(4):
        for j in range(6):
            if arr[i][j] != 0:
                continue
            else:
                return False
    return True


def human_winner(a):
    if a:
        print("You Win!")


def AI_winner(a):
    if a:
        print("You Lose!")


def evaluate(game):
    # Evaluation function: 1 game still going on, -1 game end
    if game_over_checker(game):
        return -1
    return 1


def possible_moves(board):
    moves = []
    for r in range(4):
        for c in range(6):
            if board[r][c] == 0:
                moves.append((r, c))
    random.shuffle(moves)
    return moves


def minimax(game, depth, maximizing_player):
    if depth == 0 or game_over_checker(game):
        return evaluate(game)
    if maximizing_player:
        max_eval = float('-inf')
        moves = possible_moves(game)
        for move in moves:
            new_game = [row[:] for row in game]
            simulate_move(move, new_game, 1)  # Simulate AI move
            eval = minimax(new_game, depth - 1, False)
            max_eval = max(max_eval, eval)
        return max_eval
    else:
        min_eval = float('inf')
        moves = possible_moves(game)
        for move in moves:
            new_game = [row[:] for row in game]
            simulate_move(move, new_game, 2)  # Simulate player move
            eval = minimax(new_game, depth - 1, True)
            min_eval = min(min_eval, eval)
        return min_eval


def ai_move(game):
    best_score = float('-inf')
    best_move = (1,1)
    moves = possible_moves(game)
    for move in moves:
        new_game = [row[:] for row in game]  # Create a copy of the game state
        simulate_move(move, new_game, 2)  # Modify the copied game state
        score = minimax(new_game, 4, False)  # Evaluate the modified game state
        if score > best_score:
            best_score = score
            best_move = move
    return best_move
