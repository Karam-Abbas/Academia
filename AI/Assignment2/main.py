import functions
game = functions.init_game()
functions.display_game(game)

while not functions.game_over_checker(game):
    move_r = int(input("Enter Row Number of your move (0-indexed):"))
    move_c = int(input("Enter Column Number of your move (0-indexed):"))
    move = (move_r, move_c)
    a = functions.simulate_move(move, game, 1)
    functions.display_game(game)
    over = functions.game_over_checker(game)
    if over:
        functions.human_winner(over)
        break
    ai_move_result = functions.ai_move(game)
    print(f"AI chose square at ({ai_move_result[0]}, {ai_move_result[1]})")
    functions.simulate_move(ai_move_result, game, 2)
    functions.display_game(game)
    over = functions.game_over_checker(game)
    if over:
        functions.AI_winner(over)
        break
