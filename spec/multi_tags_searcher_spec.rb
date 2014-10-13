require 'spec_helper'

RSpec.describe MultiTagsSearcher do

  before :all do
    @articles_data = [{:body=>"* [Dropwiz",
                       :coediting=>false,
                       :created_at=>"2014-08-26T14:01:18+09:00",
                       :id=>"18a0aac333cffa9732a7",
                       :private=>false,
                       :tags=>
    [{:icon_url=>"icons/medium/missing.png",
      :name=>"dropwizard",
      :versions=>["0.7"]},
    {:icon_url=>"icons/medium/missing.png",
     :name=>"jersey",
     :versions=>["1.18"]},
    {:icon_url=>
     "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/fd27fd2571b0f0c64a7fd38b62bfe670f4680e4e/medium.jpg?1387959312",
       :name=>"Java",
       :versions=>[]}],
    :title=>"Dropwizard に学ぶ / Jersey ResourceConfig",
    :updated_at=>"2014-08-26T14:01:18+09:00",
    :user=>
     {:description=>"",
      :facebook_id=>"",
      :followers_count=>5,
      :followees_count=>1,
      :github_login_name=>"tachesimazzoca",
      :id=>"tachesimazzoca",
      :items_count=>8,
      :linkedin_id=>"",
      :location=>"",
      :name=>"",
      :organization=>"",
      :profile_image_url=>
     "https://gravatar.com/avatar/ffe19c86316238d3b4c946828bbe87aa?d=https%3A%2F%2Fidenticons.github.com%2F8c7e66f06776153b57274c4b394f7f87.png&r=x",
       :twitter_screen_name=>"tachesimazzoca",
       :website_url=>"http://tachesimazzoca.github.com"}},
       {:body=>"* [Dropwiz",
        :coediting=>false,
        :created_at=>"2014-08-22T03:53:49+09:00",
        :id=>"face32a7bc1e84331b15",
        :private=>false,
        :tags=>
     [{:icon_url=>"icons/medium/missing.png",
       :name=>"dropwizard",
       :versions=>["0.7"]},
     {:icon_url=>"icons/medium/missing.png",
      :name=>"jersey",
      :versions=>["1.18"]},
     {:icon_url=>
      "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/fd27fd2571b0f0c64a7fd38b62bfe670f4680e4e/medium.jpg?1387959312",
        :name=>"Java",
        :versions=>[]}],
     :title=>"Dropwizard に学ぶ / Jersey Injection Provider",
     :updated_at=>"2014-08-26T13:53:41+09:00",
     :user=>
      {:description=>"",
       :facebook_id=>"",
       :followers_count=>5,
       :followees_count=>1,
       :github_login_name=>"tachesimazzoca",
       :id=>"tachesimazzoca",
       :items_count=>8,
       :linkedin_id=>"",
       :location=>"",
       :name=>"",
       :organization=>"",
       :profile_image_url=>
      "https://gravatar.com/avatar/ffe19c86316238d3b4c946828bbe87aa?d=https%3A%2F%2Fidenticons.github.com%2F8c7e66f06776153b57274c4b394f7f87.png&r=x",
        :twitter_screen_name=>"tachesimazzoca",
        :website_url=>"http://tachesimazzoca.github.com"}},
        {:body=>"\nDropwizar",
         :coediting=>false,
         :created_at=>"2014-08-04T00:07:33+09:00",
         :id=>"7cefba83be29f8129595",
         :private=>false,
         :tags=>
      [{:icon_url=>
        "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/fd27fd2571b0f0c64a7fd38b62bfe670f4680e4e/medium.jpg?1387959312",
          :name=>"Java",
          :versions=>[]},
      {:icon_url=>
       "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/6fc61a72204beb94f27ad76de5e4864923ae7d83/medium.jpg?1399018096",
         :name=>"gradle",
         :versions=>[]},
      {:icon_url=>
       "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/4e19a0be49d1f319a6504116d90570f878262afd/medium.jpg?1364839430",
         :name=>"Groovy",
         :versions=>[]},
      {:icon_url=>"icons/medium/missing.png",
       :name=>"dropwizard",
       :versions=>[]}],
      :title=>"Dropwizardで気軽にユーザ向けのツールを作成する",
      :updated_at=>"2014-08-04T00:07:33+09:00",
      :user=>
       {:description=>
        "Java,Groovy,Rubyが好きです。\r\n\r\nAndroid,iPhoneアプリも作ります。\r\n\r\nSwift,Scalaにも興味があるけど、我慢してます。",
          :facebook_id=>"",
          :followers_count=>19,
          :followees_count=>0,
          :github_login_name=>"ko2ic",
          :id=>"ko2ic",
          :items_count=>23,
          :linkedin_id=>"",
          :location=>"",
          :name=>"",
          :organization=>"",
          :profile_image_url=>
        "https://pbs.twimg.com/profile_images/1430777223/kai_normal.GIF",
          :twitter_screen_name=>"cyan_ishii",
          :website_url=>"http://ko2ic.github.io/"}}]

    @target_tags = ['dropwizard', 'java', 'jersey', 'gradle']

    @searcher = MultiTagsSearcher.new(@articles_data, @target_tags)
  end

  it 'はQiitaArticleのリストを生成すること' do
    @searcher.articles.each do |article|
      expect(article).to be_an_instance_of QiitaArticle
    end
  end

  describe 'のgroup_by_relevanceメソッド' do

    it 'はその関連度ごとにまとめたHashを返す' do
      result = @searcher.group_by_relevance
      result.each do |contain_tags, articles|
        articles.each do |article|
          expect(@target_tags.count{|tag| article.has_tag?(tag)}).to eq contain_tags
        end
      end
    end

  end


end
