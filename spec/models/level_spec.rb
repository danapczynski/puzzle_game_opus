require 'spec_helper'

describe Level do
  it { should have_many :scores }
  it { should have_many :users }
  
end