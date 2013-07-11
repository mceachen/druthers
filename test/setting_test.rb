require 'minitest_helper'

describe Setting do
  before :each do
    Setting.delete_all
  end

  describe 'validations' do
    def assert_saved_and_valid(key)
      Setting.where(key: key).first.valid?.must_be_true
    end

    it 'works on defined settings without a validation' do
      Setting.quest = 'to eat bacon in moderation'
      assert_saved_and_valid('quest')
    end

    it 'works on defined settings with a validation' do
      Setting.favourite_colour = 'green'
      assert_saved_and_valid('favourite_colour')
    end

    it 'raises validation errors correctly' do
      proc { Setting.favourite_colour = 'invalid' }.
        must_raise ActiveRecord::RecordInvalid
    end

    it 'allows unknown settings' do
      Setting.create do |ea|
        ea.key = 'airspeed'
      end.valid?.must_be_true
    end
  end

  describe 'defaults' do
    it 'returns proper defaults' do
      Setting.quest.must_equal 'to find the holy grail'
      Setting.favourite_colour.must_be_nil
      Setting.things.must_equal [1, 2, 3]
    end
  end

  describe 'serialized persistence' do
    it "works with arrays" do
      a = [3, 4, 5]
      Setting.things = a
      Setting.where(key: 'things').first.value.must_equal a
    end

    it "works with hashes" do
      h = {hello: 'world'}
      Setting.hashish = h
      Setting.where(key: 'hashish').first.value.must_equal h
    end
  end
end
