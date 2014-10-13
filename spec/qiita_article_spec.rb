require 'spec_helper'

RSpec.describe QiitaArticle do

  before :all do
    @article = {
      body: "body\nbody\nbody",
      coediting: false,
      created_at: "2014-10-13",
      id: "1234",
      private: false,
      tags: [
        {icon_url: 'http://icon1.icon',
         name: 'Ruby',
         versions: []},
        {icon_url: 'http://icon2.icon',
         name: 'DynamoDB',
         versions: []},
        {icon_url: 'http://icon3.icon',
         name: 'haml',
         versions: []}
      ],
      title: 'title',
      :user=> {
        :description=>nil,
        :facebook_id=>nil,
        :followers_count=>1,
        :followees_count=>4,
        :github_login_name=>nil,
        :id=>"tatsu_nishiki",
        :items_count=>1,
        :linkedin_id=>nil,
        :location=>nil,
        :name=>"",
        :organization=>nil,
        :profile_image_url=>
      "https://pbs.twimg.com/profile_images/3350167639/7a175319ce71423bc576fa68d9650448_normal.jpeg",
        :twitter_screen_name=>"tatsu_nishiki",
        :website_url=>nil
      }
    }
    @qiita_article = QiitaArticle.new(@article)
  end

  it 'はtitle属性を持つこと' do
    expect(@qiita_article.title).to be_an_instance_of String
  end

  it 'はtags属性を持つこと' do
    expect(@qiita_article.tags).to be_an_instance_of Array
  end

  it 'はbody属性を持つこと' do
    expect(@qiita_article.body).to be_an_instance_of String
  end

  describe 'のhas_tag?メソッド' do

    it 'はそのタグがついた記事ならばtrueを返すこと' do
      actual_tag = 'Ruby'
      expect(@qiita_article.has_tag?(actual_tag)).to be true
    end

    it 'はそのタグがついていない記事ならfalseを返すこと' do
      fake_tag = 'Python'
      expect(@qiita_article.has_tag?(fake_tag)).to be false
    end

    it 'は大文字小文字にかかわらない判定をすること' do
      actual_upper_tag = 'RUBY'
      actual_lower_tag = 'ruby'
      fake_upper_tag = 'PYTHON'
      fake_lower_tag = 'python'

      [actual_upper_tag, actual_lower_tag].each do |tag_name|
        expect(@qiita_article.has_tag?(tag_name)).to be true
      end

      [fake_upper_tag, fake_lower_tag].each do |tag_name|
        expect(@qiita_article.has_tag?(tag_name)).to be false
      end
    end

  end

  describe 'のget_relevanceメソッド' do

    before :all do
      @target_tags = ['haml', 'DynamoDB']
      @less_tags = ['haml']
      @more_tags = ['haml', 'DynamoDB', 'sinatra']
      @none_tags = ['rails', 'padrino', 'activerecord']
    end
    
    it 'はすべてのタグを含んでいれば1を返すこと' do
      expect(@qiita_article.get_relevance(@target_tags)).to eq 1
      expect(@qiita_article.get_relevance(@less_tags)).to eq 1
    end

    it 'は(含まれるタグ数/求めるタグ数)を返すこと' do
      expect(@qiita_article.get_relevance(@more_tags)).to eq (2/3r)
    end

    it 'はひとつもタグを含まない場合0を返すこと' do
      expect(@qiita_article.get_relevance(@none_tags)).to eq 0
    end

  end

end
