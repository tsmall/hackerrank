#!/bin/ruby

class Numeric
  def to_percent
    if self <= 1.0
      self
    else
      self / 100.0
    end
  end
end

class Bill
  attr_reader :cost, :tip_percent, :tax_percent

  def initialize(cost:, tip:, tax:)
    @cost = cost
    @tip_percent = tip.to_percent
    @tax_percent = tax.to_percent
  end

  def total
    (cost + tip + tax).round
  end

  def tip
    cost * tip_percent
  end

  def tax
    cost * tax_percent
  end
end

meal_cost = gets.strip.to_f
tip_percent = gets.strip.to_i
tax_percent = gets.strip.to_i

bill = Bill.new(cost: meal_cost, tip: tip_percent, tax: tax_percent)
puts "The total meal cost is #{bill.total} dollars."
