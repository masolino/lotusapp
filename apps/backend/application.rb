require 'sqlite3'
require 'lotus'
require 'lotus-model'
require 'lotus/model/adapters/sql_adapter'

module Backend
  class Application < Lotus::Application
    configure do
      root File.dirname(__FILE__)
      load_paths << [
        'controllers',
        'views'
      ]

      layout :backend

      routes 'config/routes'
    end
  end
end

ENV['DATABASE_URL'] = 'sqlite://development.sqlite3'

DB = Sequel.connect(ENV['DATABASE_URL'])

DB.create_table! :articles do
  primary_key :id
  String :title
  Integer :author_id
end

DB.create_table! :authors do
  primary_key :id
  String :name
end

class Article
  include Lotus::Entity
  self.attributes = :title, :author_id
end

class Author
  include Lotus::Entity
  self.attributes = :name
end

mapper = Lotus::Model::Mapper.new do
  collection :articles do
    entity Article

    attribute :id,   Integer
    attribute :title, String
    attribute :author_id, Integer
  end

  collection :authors do
    entity Author

    attribute :id,   Integer
    attribute :name, String
  end
end

class ArticleRepository
  include Lotus::Repository

  def self.by_author(author)
    query do
      where(author_id: author.id)
    end.all
  end
end

class AuthorRepository
  include Lotus::Repository
end

adapter = Lotus::Model::Adapters::SqlAdapter.new(mapper, ENV['DATABASE_URL'])

ArticleRepository.adapter = adapter
AuthorRepository.adapter  = adapter

mapper.load!

author = Author.new(name: 'Maso')
AuthorRepository.persist(author)

article = Article.new(title: 'Lotus', author_id: author.id)
ArticleRepository.persist(article)