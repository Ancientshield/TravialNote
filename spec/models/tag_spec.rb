require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag){ Tag.new }

  describe '日記標籤功能' do
    it '可以新增Tag，TagItems就有新的Tag' do
      tag.add_item 'abc'
      tag.add_item '100'
      tag.add_item ':222'
      expect(tag.tag_items[0]).to eq 'abc'
      expect(tag.tag_items[1]).to eq '100'
      expect(tag.tag_items[2]).to eq ':222'
      expect(tag.tag_items).to eq ['abc','100',':222']
    end

    it '如果加了相同的Tag，則TagItems不會增加' do
      tag.add_item 'abc'
      tag.add_item '100'
      tag.add_item 'abc'
      expect(tag.tag_items).to eq ['abc','100']

      tag.add_item 'xyz'
      tag.add_item '100'
      expect(tag.tag_items).to eq ['abc','100','xyz']
    end


    it '如果加的Tag是DisplayTags已陳列的Tag，則DisplayTags會減少該Tag' do
      tag.add_item 'ccc'
      tag.add_item '123'
      tag.add_item '456'
      expect(tag.tag_items).to eq ['ccc','123','456']
      expect(tag.display_tags).to eq ['abc','xyz']
      
      tag.add_item '123'
      expect(tag.tag_items).to eq ['ccc','123','456']
      expect(tag.display_tags).to eq ['abc','xyz']
      
      tag.add_item 'abc'
      tag.add_item 'xyz'
      expect(tag.tag_items).to eq ['ccc','123','456','abc','xyz']
      expect(tag.display_tags).to eq []
      expect(tag.user_tags).to eq ['abc','xyz','ccc','123']
    end


    it 'Tag可以放到TagItems，也可以拿出來' do
      tag.add_item 'ccc'
      tag.add_item '123'
      tag.add_item '456'
      expect(tag.tag_items).to eq ['ccc','123','456']

      tag.remove_item 'ccc'
      expect(tag.tag_items).to eq ['123','456']

      tag.remove_item '456'
      tag.remove_item '123'
      expect(tag.tag_items).to eq []
    end

    it '如果從TagItems拿出來的Tag跟UserTags的Tags是相同的，則該Tag會列入DisplayTags' do
      tag.add_item 'ccc'
      tag.add_item '123'
      tag.add_item '456'
      expect(tag.tag_items).to eq ['ccc','123','456']
      expect(tag.display_tags).to eq ['abc','xyz']
      
      tag.remove_item '123'
      expect(tag.display_tags).to eq ['abc','xyz','123']
      expect(tag.tag_items).to eq ['ccc','456']

      tag.remove_item 'ccc'
      expect(tag.display_tags).to eq ['abc','xyz','123','ccc']
      expect(tag.tag_items).to eq ['456']
      
      tag.remove_item '456'
      expect(tag.display_tags).to eq ['abc','xyz','123','ccc']
      expect(tag.tag_items).to eq []
    end

    it '可以比對TagItems的Tag，有哪些是UserTags沒有的' do
      tag.add_item 'ccc'
      tag.add_item '123'
      tag.add_item 'lalala'
      expect(tag.tag_items).to eq ['ccc','123','lalala']
      expect(tag.new_tag_filter).to eq ['lalala']
      
      tag.add_item 'bababa'
      expect(tag.new_tag_filter).to eq ['lalala','bababa']
      
      tag.remove_item 'lalala'
      tag.remove_item 'bababa'
      expect(tag.new_tag_filter).to eq []
    end

    it 'DisplayItmes不會顯示已經出現在TagItems的Tag' do
      tag.display_tags = tag.tag_filter
      expect(tag.display_tags).to eq ['123']
    end


  end

end