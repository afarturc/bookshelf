module ApplicationHelper
    def format_genre(genre)
        genre.split("_").map(&:capitalize).join(" ")
    end
end
