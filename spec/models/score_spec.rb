require 'spec_helper'

describe Score, type: :model do
  it { should belong_to :user  }
  it { should belong_to :level }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :level_id }
  it { should validate_presence_of :completion_time }
end
