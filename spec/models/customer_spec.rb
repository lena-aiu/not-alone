require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { Customer.new(first_name: "Adriana", last_name: "Cabrera", phone: "1234567890", email: "adi_111@sample.com", street: "25 N 1st", city: "San Jose", state: "CA", zip: "95128")}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a first_name" do
    subject.first_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a last_name" do
    subject.last_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a phone number" do
    subject.phone=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the phone number is not 10 chars" do
    phone = subject.phone.length
    if phone <10
      expect(subject). to_not be_valid
    end
  end
  it "is not valid if the phone number is not all digits" do
    phone = subject.phone
    if (phone.is_a? Integer) == 'false'
      expect(subject). to_not be_valid
    end
  end
  it "is not valid if the email address doesn't have a @" do
    email = subject.email
    if (email.include?("@")) == 'false'
    expect(subject.email).include ("@")
    end 
  end
  it "returns the correct full_name" do
    expect(subject.full_name).to eq("Adriana Cabrera")
  end
  it "returns the correct cust_address" do
    expect(subject.cust_address).to eq("25 N 1st San Jose CA 95128")
  end
  it "is not valid if the zip is not 5 chars" do
    zip = subject.zip.length
    if zip <5
      expect(subject). to_not be_valid
    end
  end
  it "is not valid if zip is not all digits" do
    zip = subject.zip
    if (zip.is_a? Integer) == 'false'
      expect(subject). to_not be_valid
    end
  end  
end
