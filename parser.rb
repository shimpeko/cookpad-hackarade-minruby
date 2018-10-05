require "minruby"

class MinRubyParser
  def self.minruby_parse(program)
    MinRubyParser.new.minruby_parse(program)
  end

  alias simplify_org simplify

  def simplify(exp)
    case exp[0]
    when :yield
      exp[1] = simplify(exp[1])
    when :args_add_block
      exp[1] = exp[1].map {|e| simplify(e)}[0]
    when :method_add_block
      call = simplify(exp[1])
      unless exp[2][1].nil?
        blk_params = exp[2][1][1][1].map {|a| a[1] }
      end
      blk_body = exp[2][2].map {|e_| simplify(e_) }
      call << blk_params << blk_body
    else
      simplify_org(exp)
    end
  end
end
