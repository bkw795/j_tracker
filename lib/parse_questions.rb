#!/usr/bin/env ruby
file = File.open( "game.txt" )

#Fetch categories
while line = file.gets

  (1..6).each do |count|
    (1..5).each do |subcount|

      if line.include?( "clue_J_#{count}_#{subcount}" )

        if line.include?( "clue_text" )
          question = line.split( ">" )[1].split( "<" )[0]
          question = question.gsub("&quot;","").gsub("&gt;",">").gsub("&lt;","<").gsub("&amp;","&")
          puts question + "\n\n"
        elsif line.include?( "correct_response" )
          response = line.split( "correct_response&quot;&gt;" )[1]
          response = response.gsub("&quot;","\"").gsub("&lt;","<").gsub("&gt;",">").gsub("&amp;","&")
          response = response.split( "</em" ).first.gsub( "<i>", "" ).gsub( "</i>", "" )
          puts response.strip
        end
      end

    end

  end

end

file.close

