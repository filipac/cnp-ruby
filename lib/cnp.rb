class Cnp
  def self.valid?(cnp)
    return false unless (cnp=~(/[^0-9]/)).nil? && cnp.size == 13
    require 'date'
    begin
      year = case
               when
               cnp[0].chr == "1" || cnp[0].chr == "2" then "19"
               when
               cnp[0].chr == "3" || cnp[0].chr == "4" then "18"
               when
               cnp[0].chr == "5" || cnp[0].chr == "6" then "20"
               when
               cnp[0].chr == "9" then "19" # oare se sare peste un an bisect intre 1800-2099 ?
               else return false;
             end
      year = (year + cnp[1..2]).to_i
      return false unless Date.valid_civil?(year,cnp[3..4].to_i,cnp[5..6].to_i)
    rescue ArgumentError
      return false
    end
    test_key = "279146358279"
    (0..11).inject(0){|sum, n| sum += test_key[n].chr.to_i * cnp[n].chr.to_i} % 11 == cnp[12].chr.to_i
  end
end
