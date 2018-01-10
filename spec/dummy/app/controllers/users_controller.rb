class UsersController < ActionController::Base
  def index
    @yearly_users = User.date_paginate(:created_at, :desc, date: params[:date], scope: :yearly)
    @monthly_users = User.date_paginate(:created_at, :desc, date: params[:date], scope: :monthly)
    @weekly_users = User.date_paginate(:created_at, :desc, date: params[:date], scope: :weekly)
    @daily_users = User.date_paginate(:created_at, :desc, date: params[:date], scope: :daily)

    @empty_users = User.none.date_paginate(:created_at, :desc, date: params[:date], scope: :monthly)
    @one_users = User.where(id: 1).date_paginate(:created_at, :desc, date: params[:date], scope: :monthly)
  end
end
