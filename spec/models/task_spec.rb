RSpec.describe Task, type: :model do
  it { is_expected.to have_and_belong_to_many(:tags) }
  it { is_expected.to validate_presence_of(:title) }

  describe '#tags=' do
    let(:task)      { create(:task) }
    let(:tag_names) { %w[one other]}

    context 'with tag names as argument' do
      before { task.tags = tag_names }

      it 'assigns tags to task by their names' do
        expect(task.tags.size).to         eq(2)
        expect(task.tags.map(&:title)).to match_array(tag_names)
      end
    end
  end
end
