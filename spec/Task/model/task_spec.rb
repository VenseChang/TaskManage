require 'rails_helper'

RSpec.describe Task do
  before :each do
    user = User.create(email: "task@task.task", password: "Hello World!")
    @task = Task.new(
      title: '標題',
      content: '內容',
      priority: 'ordinary',
      status: 'pending',
      end_time: Time.now,
      user_id: user.id
    )
    @task.users << user
  end

  describe "新增任務" do
    it "新增一筆任務" do
      expect(@task.save).to be true
    end
  end

  describe "修改任務" do
    it "修改任務標題" do
      @task.save
      expect(@task.update(title: "霸豆妖")).to be true
    end
  end
end