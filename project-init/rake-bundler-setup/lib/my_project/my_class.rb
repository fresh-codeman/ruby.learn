class InsufficientFundsError < StandardError; end

class BankAccount
  attr_reader :balance, :account_number, :transactions

  MINIMUM_BALANCE = 100.0

  def initialize(account_number, initial_balance = 0.0)
    @account_number = account_number
    @balance = initial_balance
    @transactions = []
    add_transaction(:open, initial_balance)
  end

  def deposit(amount)
    raise ArgumentError, "Deposit amount must be positive" if amount <= 0

    @balance += amount
    add_transaction(:deposit, amount)
    "Deposited $#{amount}. New balance: $#{balance}"
  end

  def withdraw(amount)
    raise ArgumentError, "Withdrawal amount must be positive" if amount <= 0
    if @balance - amount < MINIMUM_BALANCE
      raise InsufficientFundsError, "Cannot withdraw. Minimum balance of $#{MINIMUM_BALANCE} required."
    end

    @balance -= amount
    add_transaction(:withdraw, amount)
    "Withdrew $#{amount}. New balance: $#{balance}"
  end

  def transaction_history
    transactions.map do |t|
      "#{t[:type].capitalize}: $#{t[:amount]} on #{t[:date]}"
    end
  end

  private

  def add_transaction(type, amount)
    @transactions << { type: type, amount: amount, date: Time.now }
  end
end
