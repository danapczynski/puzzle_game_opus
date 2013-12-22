require 'spec_helper'

describe Block do
  it { should have_and_belong_to_many :levels }
  it { should validate_presence_of :shape }
  it { should validate_presence_of :nickname }

end