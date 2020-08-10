class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10).join
  end


  def include_or_not(answer, letters)
    answer.split("").each do |letter|
    letters.include? letter
    end
  end

  def score
  @answer = params[:answer]
  @letters = params[:ramdomletters]
    if include_or_not(@answer.upcase, @letters)
      ["well done !"]
    else
    "Sorry not in the random letters"
      end
    else
      ["not an english word"]
    end

  end

  def get_compar(answer)
    response = open("http://api.wordreference.com/0.8/80143/json/enfr/#{answer.downcase}")
    json = JSON.parse(response.read.to_s)
    json['term0']['PrincipalTranslations']['0']['FirstTranslation']['term'] unless json["Error"]
  end
end
