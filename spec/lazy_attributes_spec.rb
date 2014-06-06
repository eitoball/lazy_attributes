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
end
