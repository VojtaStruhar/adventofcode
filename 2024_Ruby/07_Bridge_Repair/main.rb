# frozen_string_literal: true

score = 0

File.readlines('07_Bridge_Repair/input.txt').each do |line|
  parts = line.split ' '

  desired = parts[0]
  desired = desired.gsub(':', '').to_i

  numbers = parts[1..].map(&:to_i)

  # I'm using the bits of this integer to signify if I should multiply (1) or add (0)
  multiplications = 0

  (0...(2**(numbers.length - 1))).each do |_i|
    # This is the `i`-th possible combination
    result = numbers[0]

    (0...(numbers.length - 1)).each do |j|
      should_multiply = (multiplications & (1 << j)).positive?

      if should_multiply
        result *= numbers[j + 1]
      else
        result += numbers[j + 1]
      end
    end

    multiplications += 1

    # Rubocop did this
    next unless result == desired

    # First successful combination is enough!
    score += result
    break
  end
end

puts '---' * 10
puts "SCORE: #{score}"
puts '---' * 10
