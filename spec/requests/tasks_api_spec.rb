RSpec.describe 'Tasks API', type: :request do
  let(:response_data) { response.body }

  describe 'index' do
    let!(:task) { create(:task) }

    before { get '/api/v1/tasks' }

    it 'renders list of tasks as json data' do
      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response_data).to         have_json_size(1).at_path('data')
    end
  end

  describe 'show' do
    let!(:task)           { create(:task) }
    let(:json_attributes) { { title: task.title }.to_json }

    before { get "/api/v1/tasks/#{task.id}" }

    it 'renders json data of requested task' do
      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')

      expect(response_data).to have_json_path('data/id')
      expect(response_data).to have_json_path('data/type')
      expect(response_data).to have_json_path('data/attributes')
      expect(response_data).to have_json_path('data/relationships')

      expect(response_data).to be_json_eql(json_attributes).at_path('data/attributes')
    end
  end

  describe 'create' do
    let(:params) do
      {
        data: {
          attributes: {
            title: 'New task'
          }
        }
      }
    end

    it 'saves new task to database' do
      expect{ post '/api/v1/tasks', params: params }.to change(Task, :count).by(1)

      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'update' do
    let!(:task)     { create(:task) }
    let(:new_title) { 'New title' }

    let(:params) do
      {
        id: task.id,
        data: {
          attributes: {
            title: new_title
          }
        }
      }
    end

    before do
      patch "/api/v1/tasks/#{task.id}", params: params
      task.reload
    end

    it 'updates existing task title' do
      expect(response).to              have_http_status(:ok)
      expect(response.content_type).to eq('application/json')

      expect(task.title).to eq(new_title)
    end
  end

  describe 'destroy' do
    let!(:task) { create(:task) }

    before { delete "/api/v1/tasks/#{task.id}" }

    it 'deletes task from database' do
      expect(response).to   have_http_status(:no_content)
      expect(Task.count).to eq(0)
    end
  end
end
