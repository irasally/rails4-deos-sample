require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @micropost = Micropost.new(content: "Hello my world", user_id: user.id)
  end
  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
end
