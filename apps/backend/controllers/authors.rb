module Backend::Controllers::Authors
  include Backend::Controller

  action 'Show' do
    expose :author, :articles

    def call(params)
      @author   = AuthorRepository.find(params[:id])
      @articles = ArticleRepository.by_author(@author)
    end
  end
end