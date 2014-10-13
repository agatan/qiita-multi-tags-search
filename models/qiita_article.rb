class QiitaArticle
  
  def initialize (article_hash)
    @data = article_hash
    @title = article_hash[:title]
    @url = "http://qiita.com/api/v2/items/#{article_hash[:id]}"
    @tags = article_hash[:tags].map { |tag| tag[:name] }
    @body = article_hash[:body]
  end

  attr_reader :title, :url, :tags, :body

  def has_tag?(tag_name)
    tags = @data[:tags]
    tags.any?{ |tag_info| tag_info[:name].upcase == tag_name.upcase }
  end

  def get_relevance(tags)
    contains = tags.count{ |tag| self.has_tag?(tag) }
    Rational(contains, tags.count)
  end

end
