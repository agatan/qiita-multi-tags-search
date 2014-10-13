require_relative 'qiita_api_accesser'
require_relative 'qiita_api_accesser'

class MultiTagsSearcher

  def initialize(articles_data, tags)
    @articles = articles_data.map { |data| QiitaArticle.new(data) }
    @tags = tags
  end

  attr_reader :articles

  def group_by_relevance
    @articles.group_by do |article|
      @tags.count { |tag| article.has_tag?(tag) }
    end
  end

end
