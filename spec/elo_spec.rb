require 'minitest/autorun'
require_relative '../elo.rb'

describe "Player beats another player 3 times" do
	describe "When Bob beats Joe and each has a rating of 100 and k factor of 30" do
		it "must return 141 for Bob and 59 for Joe" do
			bob = Player.new "Bob"
			joe = Player.new "Joe"	
			big_game = Game.new(bob, joe)
			
			bob.beats(joe, big_game)
			bob.beats(joe, big_game)
			bob.beats(joe, big_game)
			
			
			bob.score.round.must_equal 141
			joe.score.round.must_equal 59
			
			
		end
	end
end

describe "Player beats another player" do
	describe "When Bob beats Joe and each has a rating of 100 and k factor of 30" do
		it "must return 115 for Bob" do
			bob = Player.new "Bob"
			joe = Player.new "Joe"	
			big_game = Game.new(bob, joe)
			
			bob.beats(joe, big_game)
			
			bob.games_played.must_equal 1
			bob.score.round.must_equal 115
			
			
		end
	end
end

describe "Games played" do
	describe "When Bob plays 3 games" do
		it "must return 3 for the number of games Bob has played" do
			bob = Player.new "Bob"
			joe = Player.new "Joe"
	  
			big_game = Game.new(bob, joe)
			big_game.calc_score(winner=bob)
			big_game.calc_score(winner=joe)
			big_game.calc_score(winner=bob)
			
			bob.games_played.must_equal 3
	
		end
	end
end

describe "Game Result" do
  describe "when both players start with rating of 100 and k factor of 30"  do
    it "must return 115 for the winner" do
      bob = Player.new "Bob"
	  joe = Player.new "Joe"
	  
	  big_game = Game.new(bob, joe)
	  big_game.calc_score(winner=bob)
	  
	  bob.score.round.must_equal 115
	
    end
  end
  
   describe "when Bob starts with 100 and joe with 200 and k factor of 30 and Bob wins"  do
    it "must return 119 for Bob and 180 for Joe" do
      bob = Player.new "Bob"
	  joe = Player.new("Joe", 200)
	  
	  big_game = Game.new(bob, joe)
	  big_game.calc_score(winner=bob)
	  
	  bob.score.round.must_equal 119
	  joe.score.round.must_equal 181	
    end
	
  end
end