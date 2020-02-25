# frozen_string_literal: true
require_relative '../../../lib/simple_helper/float/trim'

RSpec.describe SimpleHelper do
  it 'it should return integer value' do
    expect(200.0.trim).to eq(200)
  end

  it 'it should round to max value' do
    expect(100.2555.trim).to eq(100.3)
  end

  it 'it should round to min value' do
    expect(100.2455.trim).to eq(100.2)
  end
end
