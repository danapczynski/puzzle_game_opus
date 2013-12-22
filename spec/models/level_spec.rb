require 'spec_helper'

describe Level do
  it { should have_many :scores }
  it { should have_many :users }
  it { should have_and_belong_to_many :blocks }
  
end