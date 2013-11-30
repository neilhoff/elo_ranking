class Player
	attr_accessor :name, :score, :games_played
	
	def initialize(name, score=100, games_played=0)
		@name = name
		@score = score
		@games_played = games_played
	end
	
	def beats(player, game)
		game.calc_score(winner=self)
	end
end

class Game
	attr_reader :player1, :player2, :k, :player1_prob, :player2_prob
	
	def initialize(player1, player2, k=30)
		@player1 = player1
		@player2 = player2
		@k = k
		@player1_prob = prob_of_winning(@player1.score, @player2.score)
		@player2_prob = prob_of_winning(@player2.score, @player1.score)
	end
	
	def prob_of_winning(player_score, opponent_score)
		1.0/(1.0+10.0**((opponent_score.to_f-player_score.to_f)/400.0))
	end

	def calc_score(winner)
		@player1.games_played += 1
		@player2.games_played += 1
		
		@player1_prob = prob_of_winning(@player1.score, @player2.score)
		@player2_prob = prob_of_winning(@player2.score, @player1.score)
		
		if winner == @player1
			@player1.score = @player1.score + @k * (1 - @player1_prob)
			@player2.score = @player2.score + @k * (0 - @player2_prob)
		else
			@player1.score = @player1.score + @k * (0 - @player1_prob)
			@player2.score = @player2.score + @k * (1 - @player2_prob)	
		end
	end
end

class Tournament
	attr_reader :games, :players, :games_left, :tournament_winner, :game
	
	def initialize(games, players=[]) 
		@games = games
		@players = players
		@games_left = @games
		@tournament_winner = ""
		@game = {}
		@tournament_type = ""
		
	end
	
	def add_player(player)
		@players << players
		#TODO: add 1 to @games when round_robin is tournament type
	end
	
	def round_robin
		@games = @players.size
		@games_left = @games
		@game = {}
	end
	
	def play_game(winner, loser)
		@games_left -= 1
		game_num = @games - @games_left
		
		game = Game.new(winner, loser)
		winner.beats(loser, game)
		
		@game[game_num] = { :winner => winner, :loser => loser}
		
		if @games_left == 0
		
		end
	end
	
end
