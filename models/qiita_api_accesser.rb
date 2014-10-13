require 'open-uri'
require 'json'

class QiitaApiAccesser

  def initialize
    @qiita_url = 'http://qiita.com/api/v2'
    @result_json = {}
  end

  def get_with_tag(tag_name)
    open("#{@qiita_url}/tags/#{tag_name}/items?page=1&per_page=100") do |uri|
      @result_json = JSON.parse(uri.read, symbolize_names: true)
    end
    @result_json
  end

end

