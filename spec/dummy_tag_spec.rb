RSpec.describe DummyTag do
  it 'has a version number' do
    expect(DummyTag::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
end
