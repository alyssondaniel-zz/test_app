class SerconprevController < ApplicationController
  def index
    @inputs = []
    @outputs = []
    File.readlines("#{Rails.public_path}/input.txt").each do |line|
      @inputs << line
      @outputs << gas_station(line)
    end
  end

  def gas_station(args)
    string   = prepare(args)
    quantity = get_quatity(string)
    i        = 1
    result   = []
    possible = 0

    while quantity >= i
      values     = get_values(string, quantity)
      parts      = get_parts(values)
      amount_gas = get_amount_gas(parts)
      gas_needed = get_gas_needed(parts)

      calc = amount_gas - gas_needed
      if calc >= 0
        result << string.index(values)
      end
      possible += calc

      quantity -= 1
    end
    text = (possible >= 0 && result.any?) ? "'#{result.min}'" : "'impossible'"

    text
  end

  private
    def prepare(string)
      string.gsub("\"","").gsub(/\n/, "").gsub(/\r/, "").split(",")
    end

    def get_quatity(string)
      string.first.to_i
    end

    def get_values(string, position)
      string[position]
    end

    def get_parts(values)
      values.split(":")
    end

    def get_amount_gas(parts)
      parts[0].to_i
    end

    def get_gas_needed(parts)
      parts[1].to_i
    end
end
