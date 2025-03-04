require_relative "../../../lib/my_project/my_class"

RSpec.describe BankAccount do
  let(:account) { BankAccount.new("12345", 500.0) }

  describe "#initialize" do
    it "sets the account number and initial balance" do
      expect(account.account_number).to eq("12345")
      expect(account.balance).to eq(500.0)
    end

    it "records an initial transaction" do
      expect(account.transactions).not_to be_empty
    end
  end

  describe "#deposit" do
    it "increases balance on deposit" do
      account.deposit(200.0)
      expect(account.balance).to eq(700.0)
    end

    it "raises an error for negative deposit" do
      expect { account.deposit(-50) }.to raise_error(ArgumentError, "Deposit amount must be positive")
    end
  end

  describe "#withdraw" do
    it "decreases balance on withdrawal" do
      account.withdraw(100.0)
      expect(account.balance).to eq(400.0)
    end

    it "raises an error when withdrawal goes below minimum balance" do
      expect { account.withdraw(450.0) }.to raise_error(InsufficientFundsError)
    end
  end

  describe "#transaction_history" do
    it "returns a list of transactions" do
      account.deposit(100)
      account.withdraw(50)
      history = account.transaction_history
      expect(history.size).to eq(3) # Initial deposit + 2 transactions
    end
  end
end
