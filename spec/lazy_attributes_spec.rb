# encoding: utf-8

require 'spec_helper'

describe LazyAttributes do
  it '' do
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

  describe '#<lazy_attribute>' do
    let!(:user) { User.create!(name: 'John', profile: 'My profile...') }

    it { expect(User.find(user.id).profile).to eq('My profile...') }

    context 'association' do
      before { user.groups.create!(name: 'Group A') }

      it 'should not reload association' do
        u = User.find(user.id)
        u.groups.build(name: 'Group B')
        expect { u.profile }.to_not change { u.groups.size }
      end
    end
  end

  describe '.attributes' do
    let!(:user) { User.create!(name: 'John', profile: 'My profile...') }

    it { expect(User.find(user.id).attributes).to be_include('profile') }
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
