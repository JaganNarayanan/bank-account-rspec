require "rspec"

require_relative "account"

describe Account do

  let(:acct_number) {"3704004402"}
  let(:account) {Account.new(acct_number)}

  describe "#initialize" do
    context "with valid input" do
      it "requires an account number argument" do
        expect(Account.new(acct_number)).to be_an_instance_of(Account)
      end
    end

    context "with invalid input" do
      it "throws an argument error when not given a type argument" do
        expect {Account.new}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#transactions" do
    it "returns an array with elements representing the transaction history" do
      expect(account.transactions).to eq([0])
    end
  end

  describe "#balance" do
    it "returns the sum of all transactions" do
      account.transactions << 3
      account.transactions << -2
      expect(account.balance).to eq(1)
    end
  end

  describe "#account_number" do
    it "returns encrypted acct_number except the last 4 digits" do
      expect(account.acct_number).to eq("******"+acct_number[-4..-1].to_s)
    end
  end

  describe "deposit!" do
    context "with valid input" do
      it "requires an integer amount argument" do
        expect{account.deposit!("a")}.to raise_error(ArgumentError)
      end
      it "adds specified negative amount to transaction" do
        account.deposit!(5)
        expect(account.transactions).to eq([0,5])
      end
      it "returns new incremented balance" do
        account.deposit!(5)
        expect(account.deposit!(15)).to eq(20)
      end
    end
    context "with invalid input" do
      it "throws an argument error when amount deposited is negative" do
        expect {account.deposit!(-5)}.to raise_error(StandardError)
      end
    end
  end

  describe "#withdraw!" do
    context "with valid input" do
      it "requires an integer amount argument" do
        expect{account.withdraw!("a")}.to raise_error(ArgumentError)
      end
      it "adds specified negative amount to transaction" do
        account = Account.new(acct_number,10)
        account.withdraw!(5)
        expect(account.transactions).to eq([10, -5])
      end
      it "returns new decremented balance" do
        account = Account.new(acct_number,10)
        expect(account.withdraw!(-5)).to eq(5)
      end
    end
  end

end
