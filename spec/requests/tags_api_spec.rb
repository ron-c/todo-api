RSpec.describe 'Tags API', type: :request do
  let(:response_data) { response.body }

  describe 'index' do
    let!(:tag) { create(:tag) }

    before { get '/api/v1/tags' }

    it 'renders list of tags as json data' do
      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response_data).to         have_json_size(1).at_path('data')
    end
  end

  describe 'create' do
    let(:params) do
      {
        data: {
          attributes: {
            title: 'New tag'
          }
        }
      }
    end

    it 'saves new tag to database' do
      expect{ post '/api/v1/tags', params: params }.to change(Tag, :count).by(1)

      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'update' do
    let!(:tag)      { create(:tag) }
    let(:new_title) { 'New tag title' }

    let(:params) do
      {
        id: tag.id,
        data: {
          attributes: {
            title: new_title
          }
        }
      }
    end

    before do
      patch "/api/v1/tags/#{tag.id}", params: params
      tag.reload
    end

    it 'updates existing tag title' do
      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')

      expect(tag.title).to eq(new_title)
    end
  end

  describe 'destroy' do
    let!(:tag) { create(:tag) }

    before { delete "/api/v1/tags/#{tag.id}" }

    it 'deletes tag from database' do
      expect(response).to   have_http_status(:no_content)
      expect(Tag.count).to eq(0)
    end
  end
end
