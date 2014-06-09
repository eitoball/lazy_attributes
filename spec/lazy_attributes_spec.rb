# encoding: utf-8

require 'spec_helper'

describe LazyAttributes do
  it '' do
    expect do
      User.send(:lazy_attributes, :profile)
      User.send(:lazy_attributes, :address)
    end.to_not raise_error

    User.create!(
      name: 'John',
      profile: 'This attribute is suppose to be very long',
      address: 'Somewhere over the rainbow'
    )

    user = User.first
    expect(user).to_not have_attribute(:profile)
    expect(user).to_not have_attribute(:address)
    expect(user.profile).to be_present
    expect(user.address).to eq('Somewhere over the rainbow')
  end

  describe '.count' do
    context 'when no user exists' do
      subject { User.count }
      it { is_expected.to eq(0) }
    end

    context 'when one user exists' do
      before { User.create! }

      subject { User.count }
      it { is_expected.to eq(1) }
    end

    context 'when two users exist' do
      before { 2.times { User.create! } }

      subject { User.count }
      it { is_expected.to eq(2) }
    end
  end
end
