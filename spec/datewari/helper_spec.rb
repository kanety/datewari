describe UsersController, type: :controller do
  render_views

  context 'renders pagination links' do
    it 'with date' do
      get :index
      expect(response.body).to include("href")
  
      get :index, params: { date: 500.days.ago }
      expect(response.body).to include("href")

      get :index, params: { date: 1000.days.ago }
      expect(response.body).to include("href")
    end

    it 'with invalid date' do
      get :index, params: { date: 100.days.after }
      expect(response.body).to include("href")
  
      get :index, params: { date: 2000.days.ago }
      expect(response.body).to include("href")

      get :index, params: { date: 'ABCDE' }
      expect(response.body).to include("href")
    end
  end
end
