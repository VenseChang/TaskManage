require 'rails_helper'

RSpec.describe Task, type: :feature do
  before :each do
    @user = User.create(email: "task@task.task", password: "Hello World!")
    @task = Task.new(title: '標題', content: '內容', priority: 'ordinary', status: 'pending', end_time: Time.now, user_id: @user.id)
    @task.users << @user
    @task.save
  end

  describe "CRUD" do
    it "新增任務" do
      visit "/tasks/new"
      fill_in :task_title, with: "新增Tag"
      fill_in :task_content, with: "內容"
      fill_in :task_user_id, with: @user.id
      click_button :submit_btn
      expect(current_path).to eq '/tasks'
      expect(page).to have_content(I18n.t(:new_success_msg, scope: [:common]))
      expect(page).to have_content("新增Tag")
    end

    it "修改任務" do
      visit "/tasks/#{@task.id}/edit"
      fill_in :task_title, with: "霸豆妖"
      fill_in :task_user_id, with: @user.id
      click_button :submit_btn
      expect(current_path).to eq '/tasks'
      expect(page).to have_content(I18n.t(:update_success_msg, scope: [:common]))
      expect(page).to have_content("霸豆妖")
    end

    it "刪除任務" do
      visit "/tasks"
      click_link I18n.t(:destroy_link, scope: [:task, :view])
      expect(current_path).to eq '/tasks'
      expect(page).to have_content(I18n.t(:destroy_success_msg, scope: [:common]))
    end
  end
end

RSpec.describe Task, type: :feature do
  before :each do
    @task_1 = Task.create(title: '新增Tag', content: '為任務新增多個Tag', priority: 'ordinary', status: 'pending', end_time: Time.now)
    @task_2 = Task.create(title: '使任務能夠排序', content: '按照Deadline排序', priority: 'ordinary', status: 'pending', end_time: Time.now+300000)
    @task_3 = Task.create(title: '網站css', content: '樣式更新', priority: 'urgent', status: 'handling', end_time: Time.now)
  end

  describe "排序" do
    it "任務列表以建立時間排序" do
      visit '/'
      expect(page.body.index("新增Tag")).to be < page.body.index("使任務能夠排序")
      click_link I18n.t(:created_at, scope: [:task, :view])
      expect(page.body.index("新增Tag")).to be > page.body.index("使任務能夠排序")
    end

    it "任務列表以結束時間排序" do
      visit '/'
      expect(page.body.index("新增Tag")).to be < page.body.index("使任務能夠排序")
      click_link I18n.t(:end_time, scope: [:task, :view])
      click_link I18n.t(:end_time, scope: [:task, :view])
      expect(page.body.index("新增Tag")).to be > page.body.index("使任務能夠排序")
    end
  end

  describe "查詢" do
    it "從標題" do
      visit '/'
      fill_in :q_title_or_content_cont, with: '新增Tag'
      click_button I18n.t(:search, scope: [:common, :views])
      expect(page).to have_content("新增Tag")
      expect(page).to_not have_content("使任務能夠排序")
      expect(page).to_not have_content("網站css")
    end

    it "從內容" do
      visit '/'
      fill_in :q_title_or_content_cont, with: '使任務能夠排序'
      click_button I18n.t(:search, scope: [:common, :views])
      expect(page).to have_content("使任務能夠排序")
      expect(page).to_not have_content("新增Tag")
      expect(page).to_not have_content("網站css")
    end

    it "從狀態" do
      visit '/'
      find('#q_status_eq').find(:xpath, 'option[3]').select_option
      click_button I18n.t(:search, scope: [:common, :views])
      expect(page).to have_content("網站css")
      expect(page).to_not have_content("新增Tag")
      expect(page).to_not have_content("使任務能夠排序")
    end
  end
end