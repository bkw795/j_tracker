#!/usr/bin/env ruby
file = File.open( "game.txt" )

j_round_cats = []
dj_round_cats = []
count = 0

#Fetch categories
while line = file.gets

  if line.include?( "class=\"category_name\"" )
    category = line.split( ">" )[2].split( "<" )[0]
    category = category.gsub( "&amp;", "&" )

    if count < 6
      j_round_cats << "\"#{category}\""
    elsif count < 12
      dj_round_cats << "\"#{category}\""
    else
      final_cat = category
    end

    count += 1
  end
end

file.close

puts "Jeopardy Round Categories are:"
puts j_round_cats.join(", ")
puts ""
puts "Double Jeopardy Round Categories are:"
puts dj_round_cats.join(", ")
puts ""
puts "The Final Jeopardy category is: #{final_cat}"

