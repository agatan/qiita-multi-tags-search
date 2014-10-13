require 'spec_helper'

RSpec.describe QiitaApiAccesser do
  describe 'のget_with_tagメソッド' do

    before :all do
      @accesser = QiitaApiAccesser.new
      @test_tag = 'c'
      @result = @accesser.get_with_tag(@test_tag)
    end

    it 'は正常なHashを含むArrayを返すこと' do
      expect(@result).to be_an_instance_of Array
      expect(@result[0]).to be_an_instance_of Hash
    end

    describe 'が空でない結果を返す時、その結果' do
      keys = %i(body created_at id private tags title updated_at user)     

      keys.each do |key|
        it "の各要素は#{key}をキーとする値を持つこと" do
          @result.each do |elem|
            expect(elem.has_key?(key)).to eq true
          end 
        end
      end
    end

  end
end
