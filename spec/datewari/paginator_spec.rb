describe Datewari::Paginator do
  context 'paginates' do
    it 'yearly' do
      users = User.date_paginate(:created_at, :asc, scope: :yearly)
      expect(users.size).not_to be 0
      users = User.all.date_paginate(:created_at, :desc, scope: :yearly)
      expect(users.size).not_to be 0
    end

    it 'monthly' do
      users = User.date_paginate(:created_at, :asc, scope: :monthly)
      expect(users.size).not_to be 0
      users = User.all.date_paginate(:created_at, :desc, scope: :monthly)
      expect(users.size).not_to be 0
    end

    it 'weekly' do
      users = User.date_paginate(:created_at, :asc, scope: :weekly)
      expect(users.size).not_to be 0
      users = User.all.date_paginate(:created_at, :desc, scope: :weekly)
      expect(users.size).not_to be 0
    end

    it 'daily' do
      users = User.date_paginate(:created_at, :asc, scope: :daily)
      expect(users.size).not_to be 0
      users = User.all.date_paginate(:created_at, :desc, scope: :daily)
      expect(users.size).not_to be 0
    end

    it 'using joined column' do
      users = User.joins(:group).date_paginate("groups.created_at", :asc, scope: :daily)
      expect(users.size).not_to be 0
    end
  end
end
