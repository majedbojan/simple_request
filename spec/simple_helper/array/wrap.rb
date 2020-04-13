# frozen_string_literal: true

require_relative '../../../lib/simple_helper/array/wrap'

RSpec.describe SimpleHelper do
  it 'return empty array' do
    expect(Array.wrap(nil)).to eq([])
  end

  it 'it return same array' do
    expect(Array.wrap([1, 2, 3])).to eq([1, 2, 3])
  end

  it 'taking hash and return array' do
    expect(Array.wrap(foo: :bar)).to eq([{ foo: :bar }])
  end
end
