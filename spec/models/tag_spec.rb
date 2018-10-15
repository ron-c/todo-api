RSpec.describe Tag, type: :model do
  it { is_expected.to have_and_belong_to_many(:tasks) }
  it { is_expected.to validate_presence_of(:title) }

  describe '::collection_from_names' do
    subject(:collection) { described_class.collection_from_names(names) }

    let(:names) { %w[one other] }

    it 'returns collection of tag instances for given collection of names' do
      is_expected.to all(be_instance_of(described_class))

      expect(collection.size).to         eq(2)
      expect(collection.map(&:title)).to match_array(names)
    end

    context 'with saved tag' do
      let(:tag_title) { 'my_tag' }
      let!(:tag)      { create(:tag, title: tag_title) }
      let(:names)     { [tag_title] }

      it 'returned collection includes previously saved tag' do
        is_expected.to match_array([tag])
      end
    end

    context 'with new tag' do
      let(:tag_title) { 'new_tag' }
      let(:names)     { [tag_title] }

      it 'returned collection includes new record of tag' do
        expect(collection.size).to        eq(1)
        expect(collection.first).to       be_instance_of(described_class)
        expect(collection.first).to       be_new_record
        expect(collection.first.title).to eq(tag_title)
      end
    end
  end
end
