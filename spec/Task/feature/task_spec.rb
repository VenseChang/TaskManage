require 'rails_helper'

RSpec.describe Task, type: :feature do
  before :each do
    @user = User.create(email: "task@task.task", password: "Hello World!")
    @task = Task.new(title: '標題', content: '內容', priority: 'ordinary', status: 'pending', end_time: Time.now, user_id: @user.id)
    @task.users << @user
    @task.save
  end

  describe "step 8" do
    it "新增任務" do
      title = "標題"
      visit "/tasks/new"
      fill_in :task_title, with: title
      fill_in :task_content, with: "內容"
      fill_in :task_user_id, with: @user.id
      click_button :submit_btn
      expect(current_path).to eq '/tasks'
      expect(page).to have_content(I18n.t(:new_success_msg, scope: [:common]))
      expect(page).to have_content(title)
    end

    it "修改任務" do
      title = "霸豆妖"
      visit "/tasks/#{@task.id}/edit"
      fill_in :task_title, with: title
      fill_in :task_user_id, with: @user.id
      click_button :submit_btn
      expect(current_path).to eq '/tasks'
      expect(page).to have_content(I18n.t(:update_success_msg, scope: [:common]))
      expect(page).to have_content(title)
    end

    it "刪除任務" do
      visit "/tasks"
      click_link I18n.t(:destroy_link, scope: [:task, :view])
      expect(current_path).to eq '/tasks'
      expect(page).to have_content(I18n.t(:destroy_success_msg, scope: [:common]))
    end
  end
end