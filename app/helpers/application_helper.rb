module ApplicationHelper

  class HTTParser
    include HTTParty
    format :html
  end

  def create_clues_from_site( site )
    game_html = HTTParser.get( site ).split( "\n" )
    show_id = 0
    game_date = nil
    count = 0
    categories = []
    questions = []
    responses = []

    game_html.each do |line|
      if line.include?("game_title")
        show_id = line.split("Show #")[1].split(" - ")[0]
        game_date = line.split(" - ")[1].split( "</h1>" )[0]
      elsif line.include?("class=\"category_name\"" )
        category = line.split( ">" )[2].split( "<" )[0]
        categories[count] = category
        count += 1
      elsif line.include?("clue_J") || line.include?( "clue_DJ" ) || line.include?( "clue_FJ" )
        if line.include?( "clue_J" )
          cat_q_ids = line.split( /clue_J_*/ )[1].split( "_" )
          cat_id = cat_q_ids[0].to_i
          q_id = cat_q_ids[1].to_i

          cell_id = ((q_id - 1) * 6) + cat_id
        elsif line.include?( "clue_DJ" )
          cat_q_ids = line.split( /clue_DJ_*/ )[1].split( "_" )
          cat_id = cat_q_ids[0].to_i + 6
          q_id = cat_q_ids[1].to_i

          cell_id = ((q_id - 1) * 6) + (cat_id - 6) + 30
        elsif line.include?( "clue_FJ" )
          cell_id = 61
        end

        if line.include?( "clue_text")
          question = line.split( "class=\"clue_text\">" )[1].split( "</td" )[0]
          question = question.gsub("&quot;","").gsub("&gt;",">").gsub("&lt;","<").gsub("&amp;","&")
          questions[cell_id] = question
        elsif line.include?( "correct_response" )
          response = line.gsub("\\&quot", "&quot").split( "correct_response&quot;&gt;" )[1]
          response = response.gsub("&quot;","\"").gsub("&lt;","<").gsub("&gt;",">").gsub("&amp;","&")
          response = response.split( "</em" ).first.gsub( "<i>", "" ).gsub( "</i>", "" )
          responses[cell_id] = response
        end
      end
    end

    game = Game.create( :show_id => show_id, :categories => categories.join("%%") )

    for index in 1..61
      questions[index] = "" if questions[index].nil?
      responses[index] = "" if responses[index].nil?
      new_clue = Clue.new( :game_id => game.id, :clue_text => questions[index], :correct_response => responses[index], :category => categories[ category_index_by_cell_id( index )], :value => value_by_cell_id( index ), :round => round_by_cell_id( index ), :cell_id => index)
      new_clue.save
    end
  end

  def category_index_by_cell_id( cell_id )
    case cell_id
    when 1..30
      return (cell_id % 6 == 0) ? 5 : ( cell_id % 6 ) - 1
    when 31..60
      return (cell_id % 6 == 0) ? 11 : ( cell_id % 6 ) + 5
    when 61
      return 12
    else
      return ""
    end
  end

  def value_by_cell_id( cell_id )
    case cell_id
    when 1..30
      return (( cell_id / 6 ) + 1) * 200
    when 31..60
      return (( cell_id / 6 ) - 4) * 400
    else
      return -1
    end
  end

  def round_by_cell_id( cell_id )
    case cell_id
    when 1..30
      return 1
    when 31..60
      return 2
    when 61
      return 3
    else
      return -1
    end
  end

end
