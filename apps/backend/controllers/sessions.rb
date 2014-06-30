module Backend::Controllers::Sessions
  include Backend::Controller

  action 'New' do
    expose :author, :article

    def call(params)
      @author  = AuthorRepository.find(params[:id])
      @article = ArticleRepository.by_author(@author)
    end
  end
end