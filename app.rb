require 'sinatra/base'
require 'sinatra/reloader'
require 'haml'

require_relative 'models/init'

class QiitaMultiTags < Sinatra::Base
  register Sinatra::Reloader

  get '/' do
    haml :index
  end

  get '/search' do
    accesser = QiitaApiAccesser.new
    articles = accesser.get_with_tag(params[:main_tag])
    @relevances = MultiTagsSearcher.new(articles, [params[:main_tag], params[:sub_tag1], params[:sub_tag2]]).group_by_relevance
    @tags = [1, 2, 3]
    haml :result
  end

end
