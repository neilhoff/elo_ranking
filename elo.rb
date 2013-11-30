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
	attr_reader :games, :players
	
	def initialize(games, players=[]) 
		@games = games
		@players = players
		
	end
	
	def add_player(player)
		@players << players
	end
	
end



bob = Player.new "Bob"
joe = Player.new "Joe", 200	

t = Tournament.new(5,[bob,joe])
t.players.each do |x|
	puts x.name
	puts x.score
end
