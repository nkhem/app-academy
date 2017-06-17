require 'byebug'
require 'base_helpers'
require 'mid_helpers'

def perfect_bits(num1, num2)
  return is_perfect_bit?(num1) if num1 == num2
  num1 = is_perfect_bit?(num1) ? num1 : next_perfect_bit(num1)
  num2 = is_perfect_bit?(num2) ? num2 : prev_perfect_bit(num2)
  count = 0

  if no_binary_bases_in_range?(num1, num2)
    prev_binary_base_before_range = prev_binary_base(num1)
    next_binary_base_beyond_range = next_binary_base(num2)

    #get count for full range
    count += count_perms_in_mid_range_noninclusive(prev_binary_base_before_range, next_binary_base_beyond_range)

    #subtract initial chunk before num1
    count -= count_perms_in_initial_range_noninclusive(prev_binary_base_before_range, num1)

    #subtract final chunk beyond num2
    count -= count_perms_in_final_range_inclusive(num2, next_binary_base_beyond_range)
  else
    count += count_perms_in_initial_range_noninclusive(num1, num2)
    count += count_perms_in_mid_range_noninclusive(num1, num2)
    count += count_perms_in_final_range_inclusive(num1, num2)
  end

  count
end

p '---initial range---'
p 'perfect_bits(10, 16) == 2'
p perfect_bits(10, 16) == 2
p 'perfect_bits(100, 128) == 10'
p perfect_bits(100, 128) == 10
p perfect_bits(1000, 1024) == 6
p perfect_bits(30000, 32768) == 651 => perfect_bits(30000, 32768)
p perfect_bits(1099511000000, 1099511627776) == 8657 => perfect_bits(1099511000000, 1099511627776)
# num1 = 1099511000000
# num2 = 1099511627776
# p 'initial', count_perms_in_initial_range_noninclusive(num1, num2)
# p 'mid', count_perms_in_mid_range_noninclusive(num1, num2)
# p 'final', count_perms_in_final_range_inclusive(num1, num2)
p perfect_bits(9223372036854770000, 9223372036854775808)==1

p '---mid range---'
p perfect_bits(2, 4) == 2
p perfect_bits(16, 32) == 6
p perfect_bits(128, 256) == 37
p perfect_bits(16384, 32768) == 3369
p perfect_bits(2, 9223372036854775808)==734248687150654971
p perfect_bits(128, 1099511627776)==103351068365

p '---final range, inclusive---'
p perfect_bits(4, 11) == 2 =>perfect_bits(4, 11)
p perfect_bits(16, 28) == 2 =>perfect_bits(16, 28)
p perfect_bits(32, 46) == 5 =>perfect_bits(32, 46)
p perfect_bits(16384, 30000) == 2719 =>perfect_bits(16384, 30000)
# num1 = 16384
# num2 = 30000
# p 'initial', count_perms_in_initial_range_noninclusive(num1, num2)
# p 'mid', count_perms_in_mid_range_noninclusive(num1, num2)
# p 'final', count_perms_in_final_range_inclusive(num1, num2)
p perfect_bits(9223372036854775807, 9223372036854775815)==2 =>perfect_bits(9223372036854775807, 9223372036854775815)

p '---initial+mid range, non-inclusive---'
p perfect_bits(10, 32) == 7
p perfect_bits(30, 64) == 13
p perfect_bits(100, 256) == 46

p '---middle of mid range--'
p '---mid+final range, inclusive---'
p perfect_bits(16, 39)==7
p perfect_bits(16, 40)==6
p perfect_bits(16, 43)==8
p perfect_bits(16, 44)==7
p perfect_bits(16, 45)==9
p perfect_bits(16, 46)==10
p perfect_bits(16, 47)==9
p perfect_bits(16, 140)==39

# p '--when a === b---'
# p perfect_bits(32768, 32768) == 1
# p perfect_bits(32767, 32767) == 0
