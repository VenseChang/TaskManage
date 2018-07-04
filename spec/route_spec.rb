RSpec.describe "Routing root", :type => :routing do
  it "to task index" do
      expect(:get => "/").to route_to("tasks#index")
  end
end