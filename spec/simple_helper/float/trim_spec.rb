# frozen_string_literal: true

RSpec.describe Float do
  it 'it should return integer value' do
    expect(200.0.trim).to eq(200)
  end

  it 'it should round to max value' do
    expect(100.2555.trim).to eq(200)
  end

  it 'it should round to min value' do
    expect(100.2455.trim).to eq(200)
  end
end
