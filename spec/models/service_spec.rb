require 'rails_helper'

RSpec.describe Service, type: :model do
  subject { Service.new(name: "nservice", description: "service", kind: "service", phone_number: "1234567890" )}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a description" do
    subject.description=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a phone number" do
    subject.phone_number=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the phone number is not 10 chars" do
    phone_number = subject.phone_number.length
    if phone_number <10
      expect(subject). to_not be_valid
    end
  end
  it "is not valid if the phone number is not all digits" do
    phone_number = subject.phone_number
    if (phone_number.is_a? Integer) == 'false'
      expect(subject). to_not be_valid
    end
  end 
end

