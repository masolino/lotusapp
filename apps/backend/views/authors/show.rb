module Backend::Views::Authors
  class Show
    include Backend::View

    def articles
      locals[:articles].map! do |article|
        article.title = article.title.upcase
        article
      end

      locals[:articles]
    end

    def page_title
      "#{ layout.page_title } #{ author.name }"
    end
  end
end