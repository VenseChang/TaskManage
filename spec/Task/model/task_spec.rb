require 'rails_helper'

RSpec.describe Task, type: :model do
  before :each do
    @user = User.create(email: "task@task.task", password: "Hello World!")
    @task = Task.new(title: '標題', content: '內容', priority: 'low', status: 'pending', end_time: Time.now, user_id: @user.id)
  end

  describe "新增任務" do
    it "新增一個任務，但忘記打標題" do
      @task.title = nil
      expect(@task.save).to be false
    end
  
    it "新增一個任務，但沒輸入任務內容" do
      @task.content = nil
      expect(@task.save).to be false
    end
  
    it "新增一個任務，但沒選擇 Priority" do
      @task.priority = nil
      expect(@task.save).to be false
    end
  
    it "新增一個任務，但沒選擇狀態" do
      @task.status = nil
      expect(@task.save).to be false
    end
  
    it "新增一個任務，但沒輸入結束時間" do
      @task.end_time = nil
      expect(@task.save).to be false
    end
  
    it "Task 要和 User 建立 has_and_belongs_to_many 關係" do
      @task = Task.reflect_on_association(:users)
      expect(@task.macro).to be :has_and_belongs_to_many
    end
  end
  
  describe "修改任務" do
    it "修改任務時，標題不能為空" do
      @task.save
      expect(@task.update(title: nil)).to be false
    end
  
    it "修改任務時，內容不能為空" do
      @task.save
      expect(@task.update(content: nil)).to be false
    end
  end
  
  describe "查詢任務" do
    it "儲存任務後，應該要能透過 Db 查詢到該筆資料" do
      @task.save
      expect(@task.id).to be Task.find(@task.id).id
    end
  end
end