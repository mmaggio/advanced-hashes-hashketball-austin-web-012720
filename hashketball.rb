def game_hash 
  game_hash = {:home=> 
                {:team_name=> "Brooklyn Nets" ,
                 :colors=> 
                   ["Black" , 
                   "White" 
                   ],
                 :players=> 
                   [
                     { :player_name => "Alan Anderson",
                       :number =>  0,
                       :shoe =>  16,
                       :points =>  22,
                       :rebounds => 12,
                       :assists =>12,
                       :steals => 3,
                       :blocks => 1,
                       :slam_dunks => 1
                      },
                      { :player_name => "Reggie Evans" ,
                       :number => 30,
                       :shoe => 14,
                       :points => 12,
                       :rebounds => 12,
                       :assists => 12,
                       :steals => 12,
                       :blocks => 12,
                       :slam_dunks => 7
                      },
                      {:player_name => "Brook Lopez" ,
                       :number => 11 ,
                       :shoe => 17,
                       :points => 17,
                       :rebounds => 19,
                       :assists => 10,
                       :steals => 3,
                       :blocks => 1,
                       :slam_dunks => 15
                      },
                      {:player_name => "Mason Plumlee",
                       :number => 1,
                       :shoe => 19,
                       :points => 26,
                       :rebounds => 11,
                       :assists => 6,
                       :steals => 3,
                       :blocks => 8,
                       :slam_dunks => 5
                      },
                      {:player_name =>"Jason Terry",
                       :number => 31,
                       :shoe => 15,
                       :points => 19,
                       :rebounds => 2,
                       :assists => 2,
                       :steals => 4,
                       :blocks => 11,
                       :slam_dunks => 1
                      }
                    ]
                }, 
               :away=> 
                 {:team_name=> "Charlotte Hornets" ,
                  :colors=> 
                    ["Turquoise" , 
                    "Purple"
                    ],
                  :players=> 
                    [
                      {:player_name => "Jeff Adrien",
                       :number => 4,
                       :shoe => 18,
                       :points => 10,
                       :rebounds => 1,
                       :assists => 1,
                       :steals => 2,
                       :blocks => 7,
                       :slam_dunks => 2 
                      },
                     {:player_name => "Bismack Biyombo",
                       :number => 0,
                       :shoe => 16,
                       :points => 12,
                       :rebounds => 4,
                       :assists => 7,
                       :steals => 22,
                       :blocks =>  15,
                       :slam_dunks => 10
                      },
                      {:player_name => "DeSagna Diop",
                       :number => 2,
                       :shoe => 14,
                       :points => 24,
                       :rebounds => 12,
                       :assists => 12,
                       :steals => 4,
                       :blocks => 5,
                       :slam_dunks => 5 
                      },
                      {:player_name => "Ben Gordon",
                       :number => 8,
                       :shoe => 15,
                       :points => 33,
                       :rebounds => 3,
                       :assists => 2,
                       :steals => 1,
                       :blocks => 1,
                       :slam_dunks => 0
                      },
                      {:player_name => "Kemba Walker",
                       :number => 33,
                       :shoe => 15,
                       :points => 6,
                       :rebounds => 12,
                       :assists => 12,
                       :steals => 7,
                       :blocks => 5,
                       :slam_dunks => 12
                      }
                    ]
                 }
              }
end

def get_player_stat_hash # sets all ten players' names as keys equal to their stats used in a number of methods below
  consolidated_player_list = game_hash[:home][:players] + game_hash[:away][:players]
  player_stat_hash = {}
  consolidated_player_list.each do |player|
    key = player[:player_name]
    player_stat_hash[key] = player
  end
  player_stat_hash
end

def get_player_names_array # creates array of ten players' names used in a number of methods below
  player_stat_hash = get_player_stat_hash
  player_names_array = []
  player_names_array = player_stat_hash.map do |player|
    player[0]
  end
  player_names_array
  end

def get_player_stat(name, stat)
   player_stat_hash = get_player_stat_hash
   player_stat = 0
    player_stat_hash.each do |player|
      player_stat = player[1][stat] if player[0] == name
    end
    player_stat
  end

def num_points_scored(name)
  stat = :points
  get_player_stat(name, stat)
end

def shoe_size(name)
  stat = :shoe
  get_player_stat(name, stat)
end

def player_stats(name)
  player_stat_hash = get_player_stat_hash
  stats = {}
    player_stat_hash.each do |player|
    stats = player[1] if player[0] == name
  end
  stats.delete(:player_name) #removes redundant player name
  stats
end

def team_names
 [ game_hash[:home][:team_name],
   game_hash[:away][:team_name] ]
end

def team_colors(team_name)
  if game_hash[:home][:team_name] == team_name
    colors = game_hash[:home][:colors]
  else
    colors = game_hash[:away][:colors]
  end
  colors
end

def player_numbers(team_name)
  jersey_array = []
  if game_hash[:home][:team_name] == team_name
    jersey_array = game_hash[:home][:players].map do |player|
       player[:number]
    end
  else
    jersey_array = game_hash[:away][:players].map do |player|
       player[:number]
    end
  end
  jersey_array
end

def big_shoe_rebounds
  player_stat_hash = get_player_stat_hash
  player_names_array = get_player_names_array
  player_big_shoe = player_names_array[0]
  player_names_array.each do |name|
    player_big_shoe = name if shoe_size(name) > shoe_size(player_big_shoe)
  end
  player_stat_hash[player_big_shoe][:rebounds]
 end
 
def most_points_scored
  player_stat_hash = get_player_stat_hash
  player_names_array = get_player_names_array
  player_most_points = player_names_array[0]
   player_names_array.each do |name|
     player_most_points = name if get_player_stat(name, :points) > get_player_stat(player_most_points, :points)
   end
  player_most_points
 end

def winning_team
  player_stat_hash = get_player_stat_hash
  #creates array of ten players' points
  points = player_stat_hash.map do |player|
   player[1][:points]
  end
  home_total = (points.slice(0..4)).sum
  away_total = (points.slice(5..9)).sum
  # compare home versus away total
  if home_total > away_total
  winner = game_hash[:home][:team_name]
  else
  winner = game_hash[:home][:team_name]
  end
  winner
end

def player_with_longest_name
  player_stat_hash = get_player_stat_hash
  player_names_array = get_player_names_array
  player_longest_name = player_names_array[0]
   player_names_array.each do |name|
     player_longest_name = name if name.size > player_longest_name.size
   end
  player_longest_name
end

def most_steals
  player_stat_hash = get_player_stat_hash
  player_names_array = get_player_names_array
  player_most_steals = player_names_array[0]
   player_names_array.each do |name|
     player_most_steals = name if get_player_stat(name, :steals) > get_player_stat(player_most_steals, :steals)
   end
  player_most_steals
 end

def long_name_steals_a_ton?
  if player_with_longest_name == most_steals
    true
  else
    false
  end
end

