require 'spec_helper'

describe Campaign do
  it { should belong_to :user }
end