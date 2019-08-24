describe UsersController, type: :request do
  context 'renders pagination links' do
    it 'with date' do
      get users_path
      expect(response.body).to include("href")
  
      get users_path, params: { date: 500.days.ago }
      expect(response.body).to include("href")

      get users_path, params: { date: 1000.days.ago }
      expect(response.body).to include("href")
    end

    it 'with invalid date' do
      get users_path, params: { date: 100.days.since }
      expect(response.body).to include("href")
  
      get users_path, params: { date: 2000.days.ago }
      expect(response.body).to include("href")

      get users_path, params: { date: 'ABCDE' }
      expect(response.body).to include("href")
    end
  end
end
