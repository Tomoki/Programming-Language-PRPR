#
# DO NOT MODIFY!!!!
# This file is automatically generated by racc 1.4.5
# from racc grammer file "calc.y".
#

require 'racc/parser'


# $Id: calc.y,v 1.4 2005/11/20 13:29:32 aamine Exp $

class VarNode
  def initialize(name)
    @name = name
  end
  def eval(var_table)
    return var_table[@name]
  end
end

class NumberNode
  def initialize(value)
    @value = value
  end
  def eval(var_table)
    return @value
  end
end

class StringNode
  def initialize(value)
    @value = value
  end
  def eval(var_table)
    return @value
  end
end

class AddNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Add node|\n| #{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) + @right.eval(var_table)
  end
end

class MinusNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Minus node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) - @right.eval(var_table)
  end
end

class MultipleNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Multiple node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) * @right.eval(var_table)
  end
end

class DevNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Dev node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    return @left.eval(var_table) / @right.eval(var_table)
  end
end

class ModNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "|Mod node|\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    @left.eval(var_table)% @right.eval(var_table)
  end
end

class UMinusNode
  def initialize(num)
    @num = num
  end
  def to_s()
    return "|UMinus node|\n|#{@num}"
  end
  def eval(var_table)
    return -1 * @num.eval(var_table)
  end
end

class EqualNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def to_s()
    return "Mod node\n|#{"-"*(@right.to_s.length+2)}|\n#{@left}  #{@right}"
  end
  def eval(var_table)
    var_table[@left] = @right.eval(var_table)
  end
end

class BoolNode
  def initialize(bool)
    @bool = bool
  end
  def eval(var_table)
    return @bool
  end
end


class IsNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(var_table)
    return BoolNode.new(@left.eval(var_table)==@right.eval(var_table)).eval(var_table)
  end
end

class IsNotNode
  def initialize(left,right)
    @left = left
    @right = right
  end
  def eval(var_table)
    return BoolNode.new(@left.eval(var_table)!=@right.eval(var_table)).eval(var_table)
  end
end

class IfNode
  def initialize(boolexp,exp)
    @boolexp = boolexp
    @exp = exp
  end
  def eval(var_table)
    if @boolexp.eval(var_table)
      return @exp.eval(var_table)
    end
  end
end

class ForNode
  def initialize(initexp,boolexp,doexp)
    @initexp = initexp
    @boolexp = boolexp
    @doexp = doexp
  end
  def eval(var_table)
    @initexp.eval(var_table)
    while(not @boolexp.eval(var_table))
      @doexp.eval(var_table)
    end
  end
end

class IfElseNode
  def initialize(boolexp,trueexp,falseexp)
    @boolexp = boolexp
    @trueexp = trueexp
    @falseexp = falseexp
  end
  def eval(var_table)
    if @boolexp.eval(var_table)
      return @trueexp.eval(var_table)
    else
      return @falseexp.eval(var_table)
    end
  end
end

class BlockNode
  def initialize(nodelist)
    @nodelist = nodelist
  end
  def eval(var_table)
    answer = 0
    @nodelist.each do |node|
      answer = node.eval(var_table)
    end
    return answer
  end
end

class PrintNode
  def initialize(value)
    @value = value
  end
  def eval(var_table)
    puts @value.eval(var_table)
  end
end

class Calcp < Racc::Parser

module_eval <<'..end calc.y modeval..idc6f4657cb9', 'calc.y', 262

  def initialize()
    @nodes = []
  end

  def parse(str)
    @q = []
    until str.empty?
      case str
      when /\A\s+/
      when /\A\d+\.?\d*/
        @q.push [:NUMBER, $&.to_f]
      when /\Aif/
        @q.push [:IF,nil]
      when /\Aisnot/
        @q.push [:ISNOT,nil]
      when /\Ais/
        @q.push [:IS,nil]
      when /\Athen/
        @q.push [:THEN,nil]
      when /\Aelse/
        @q.push [:ELSE,nil]
      when /\Aprint/
        @q.push [:PRINT,nil]
      when /\Afor/
        @q.push [:FOR,nil]
      when /\Ato/
        @q.push [:TO,nil]
      when /\Ado/
        @q.push [:DO,nil]
      when /\A"(.*?)"/
        @q.push [:STRING,$1]
      when /\A\w+/
        @q.push [:VAR,$&.to_s]
      when /\A.|\n/o
        s = $&
        @q.push [s, s]
      end
      str = $'
    end
    @q.push [false, '$end']
    do_parse
  end

  def next_token
    @q.shift
  end

..end calc.y modeval..idc6f4657cb9

##### racc 1.4.5 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 1, 27, :_reduce_none,
 0, 27, :_reduce_2,
 3, 28, :_reduce_3,
 3, 28, :_reduce_4,
 3, 28, :_reduce_5,
 3, 28, :_reduce_6,
 3, 28, :_reduce_7,
 3, 28, :_reduce_8,
 3, 28, :_reduce_9,
 2, 28, :_reduce_10,
 4, 28, :_reduce_11,
 6, 28, :_reduce_12,
 6, 28, :_reduce_13,
 3, 28, :_reduce_14,
 3, 28, :_reduce_15,
 2, 28, :_reduce_16,
 3, 28, :_reduce_17,
 1, 28, :_reduce_18,
 1, 28, :_reduce_19,
 1, 28, :_reduce_20,
 0, 29, :_reduce_21,
 1, 29, :_reduce_22,
 3, 29, :_reduce_23 ]

racc_reduce_n = 24

racc_shift_n = 49

racc_action_table = [
     9,    41,    16,    13,     1,    24,     4,    31,   nil,     6,
   nil,    40,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,     9,     2,     3,     5,     1,
   nil,     4,   nil,   nil,     6,   nil,   nil,    10,   nil,    11,
     9,     2,     3,     5,     1,   nil,     4,   nil,   nil,     6,
   nil,   nil,    10,   nil,    11,   nil,     2,     3,     5,    17,
    18,    19,    20,    21,    22,    23,    17,    18,    19,    20,
    21,    22,    23,    17,    18,    19,    39,    17,    18,    19,
   nil,    46,    17,    18,    19,    20,    21,    22,    23,    17,
    18,    19,    20,    21,    22,    23,    30,   nil,   nil,   nil,
   nil,    45,    17,    18,    19,    20,    21,    22,    23,   nil,
   nil,   nil,   nil,    29,    17,    18,    19,    20,    21,    22,
    23,    17,    18,    19,    20,    21,    22,    23,    17,    18,
    19,    20,    21,    22,    23,    17,    18,    19,    20,    21,
    22,    23,    17,    18,    19,    20,    21,    22,    23,    17,
    18,    19,    20,    21,    22,    23,    17,    18,    19,    20,
    21,    22,   -24,    17,    18,    19,    20,    21,    22,    23,
    17,    18,    19,    20,    21,   -24 ]

racc_action_check = [
     0,    27,     7,     3,     0,     9,     0,    16,   nil,     0,
   nil,    27,     0,   nil,     0,     1,     0,     0,     0,     1,
   nil,     1,   nil,   nil,     1,   nil,   nil,     1,   nil,     1,
    46,     1,     1,     1,    46,   nil,    46,   nil,   nil,    46,
   nil,   nil,    46,   nil,    46,     4,    46,    46,    46,     4,
   nil,     4,   nil,   nil,     4,   nil,   nil,     4,   nil,     4,
     6,     4,     4,     4,     6,   nil,     6,   nil,   nil,     6,
   nil,   nil,     6,   nil,     6,    45,     6,     6,     6,    45,
   nil,    45,   nil,   nil,    45,   nil,   nil,    45,   nil,    45,
    41,    45,    45,    45,    41,   nil,    41,   nil,   nil,    41,
   nil,   nil,    41,   nil,    41,    30,    41,    41,    41,    30,
   nil,    30,   nil,   nil,    30,   nil,   nil,    30,   nil,    30,
    10,    30,    30,    30,    10,   nil,    10,   nil,   nil,    10,
   nil,   nil,    10,   nil,    10,    11,    10,    10,    10,    11,
   nil,    11,   nil,   nil,    11,   nil,   nil,    11,   nil,    11,
    29,    11,    11,    11,    29,   nil,    29,   nil,   nil,    29,
   nil,   nil,    29,   nil,    29,    13,    29,    29,    29,    13,
   nil,    13,   nil,   nil,    13,   nil,   nil,    13,   nil,    13,
    23,    13,    13,    13,    23,   nil,    23,   nil,   nil,    23,
   nil,   nil,    23,   nil,    23,    20,    23,    23,    23,    20,
   nil,    20,   nil,   nil,    20,   nil,   nil,    20,   nil,    20,
    21,    20,    20,    20,    21,   nil,    21,   nil,   nil,    21,
   nil,   nil,    21,   nil,    21,    17,    21,    21,    21,    17,
   nil,    17,   nil,   nil,    17,   nil,   nil,    17,   nil,    17,
    18,    17,    17,    17,    18,   nil,    18,   nil,   nil,    18,
   nil,   nil,    18,   nil,    18,    19,    18,    18,    18,    19,
   nil,    19,   nil,   nil,    19,   nil,   nil,    19,   nil,    19,
    22,    19,    19,    19,    22,   nil,    22,   nil,   nil,    22,
   nil,   nil,    22,   nil,    22,   nil,    22,    22,    22,    25,
    25,    25,    25,    25,    25,    25,    43,    43,    43,    43,
    43,    43,    43,    35,    35,    35,    25,    36,    36,    36,
   nil,    43,    15,    15,    15,    15,    15,    15,    15,    42,
    42,    42,    42,    42,    42,    42,    15,   nil,   nil,   nil,
   nil,    42,    14,    14,    14,    14,    14,    14,    14,   nil,
   nil,   nil,   nil,    14,    47,    47,    47,    47,    47,    47,
    47,    12,    12,    12,    12,    12,    12,    12,    28,    28,
    28,    28,    28,    28,    28,    26,    26,    26,    26,    26,
    26,    26,    44,    44,    44,    44,    44,    44,    44,     8,
     8,     8,     8,     8,     8,     8,    38,    38,    38,    38,
    38,    38,    38,    48,    48,    48,    48,    48,    48,    48,
    37,    37,    37,    37,    37,    37 ]

racc_action_pointer = [
    -7,     8,   nil,    -7,    38,   nil,    53,     2,   376,   -18,
   113,   128,   348,   158,   329,   309,     7,   218,   233,   248,
   188,   203,   263,   173,   nil,   286,   362,   -11,   355,   143,
    98,   nil,   nil,   nil,   nil,   300,   304,   397,   383,   nil,
   nil,    83,   316,   293,   369,    68,    23,   341,   390 ]

racc_action_default = [
    -2,   -24,   -18,   -19,   -24,   -20,   -24,   -24,    -1,   -24,
   -24,   -21,   -10,   -24,   -24,   -24,   -24,   -24,   -24,   -24,
   -24,   -24,   -24,   -24,   -16,   -24,   -22,   -24,   -17,   -24,
   -24,    49,    -5,    -6,    -7,    -3,    -4,    -8,    -9,   -14,
   -15,   -24,   -11,   -24,   -23,   -24,   -24,   -12,   -13 ]

racc_goto_table = [
     8,    12,     7,    27,    14,   nil,    15,   nil,   nil,   nil,
    25,    26,   nil,    28,   nil,   nil,   nil,    32,    33,    34,
    35,    36,    37,    38,   nil,   nil,   nil,   nil,   nil,    42,
    43,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    44,   nil,   nil,   nil,    47,    48 ]

racc_goto_check = [
     2,     2,     1,     3,     2,   nil,     2,   nil,   nil,   nil,
     2,     2,   nil,     2,   nil,   nil,   nil,     2,     2,     2,
     2,     2,     2,     2,   nil,   nil,   nil,   nil,   nil,     2,
     2,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,     2,   nil,   nil,   nil,     2,     2 ]

racc_goto_pointer = [
   nil,     2,     0,    -8 ]

racc_goto_default = [
   nil,   nil,   nil,   nil ]

racc_token_table = {
 false => 0,
 Object.new => 1,
 :UMINUS => 2,
 "*" => 3,
 "/" => 4,
 "%" => 5,
 "+" => 6,
 "-" => 7,
 :IS => 8,
 :ISNOT => 9,
 "=" => 10,
 :PRINT => 11,
 ";" => 12,
 :IF => 13,
 :THEN => 14,
 :ELSE => 15,
 :FOR => 16,
 :TO => 17,
 :DO => 18,
 "(" => 19,
 ")" => 20,
 "{" => 21,
 "}" => 22,
 :NUMBER => 23,
 :VAR => 24,
 :STRING => 25 }

racc_use_result_var = true

racc_nt_base = 26

Racc_arg = [
 racc_action_table,
 racc_action_check,
 racc_action_default,
 racc_action_pointer,
 racc_goto_table,
 racc_goto_check,
 racc_goto_default,
 racc_goto_pointer,
 racc_nt_base,
 racc_reduce_table,
 racc_token_table,
 racc_shift_n,
 racc_reduce_n,
 racc_use_result_var ]

Racc_token_to_s_table = [
'$end',
'error',
'UMINUS',
'"*"',
'"/"',
'"%"',
'"+"',
'"-"',
'IS',
'ISNOT',
'"="',
'PRINT',
'";"',
'IF',
'THEN',
'ELSE',
'FOR',
'TO',
'DO',
'"("',
'")"',
'"{"',
'"}"',
'NUMBER',
'VAR',
'STRING',
'$start',
'target',
'exp',
'explist']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

 # reduce 1 omitted

module_eval <<'.,.,', 'calc.y', 20
  def _reduce_2( val, _values, result )
 result = NumberNode.new(0)
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 22
  def _reduce_3( val, _values, result )
 result = AddNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 23
  def _reduce_4( val, _values, result )
 result = MinusNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 24
  def _reduce_5( val, _values, result )
 result = MultipleNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 25
  def _reduce_6( val, _values, result )
 result = DevNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 26
  def _reduce_7( val, _values, result )
 result = ModNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 27
  def _reduce_8( val, _values, result )
 result = IsNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 28
  def _reduce_9( val, _values, result )
 result = IsNotNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 29
  def _reduce_10( val, _values, result )
 result = PrintNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 30
  def _reduce_11( val, _values, result )
 result = IfNode.new(val[1],val[3])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 31
  def _reduce_12( val, _values, result )
 result = IfElseNode.new(val[1],val[3],val[5])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 32
  def _reduce_13( val, _values, result )
 result = ForNode.new(val[1],val[3],val[5])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 33
  def _reduce_14( val, _values, result )
 result = val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 34
  def _reduce_15( val, _values, result )
result = BlockNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 35
  def _reduce_16( val, _values, result )
 result = UMinusNode.new(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 36
  def _reduce_17( val, _values, result )
 result = EqualNode.new(val[0],val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 37
  def _reduce_18( val, _values, result )
result = NumberNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 38
  def _reduce_19( val, _values, result )
 result = VarNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 39
  def _reduce_20( val, _values, result )
 result = StringNode.new(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 41
  def _reduce_21( val, _values, result )
result = []
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 42
  def _reduce_22( val, _values, result )
result=[val[0]]
   result
  end
.,.,

module_eval <<'.,.,', 'calc.y', 43
  def _reduce_23( val, _values, result )
result=val[0] << val[2]
   result
  end
.,.,

 def _reduce_none( val, _values, result )
  result
 end

end   # class Calcp


if ARGV.length == 0
    parser = Calcp.new
    puts
    puts 'type "Q" to quit.'
    puts
    var = {}
    while true
      puts
      print '? '
      str = gets.chop!
      break if /q/i =~ str
      begin
        parsed = parser.parse(str)
        parsed.eval(var)
      rescue ParseError
        puts $!
      end
    end
else
    parser = Calcp.new
    var = {}
    f = open(ARGV[0])
    begin
      str = f.read
      parsed = parser.parse(str)
      parsed.eval(var)
    rescue ParseError => e
      puts e
    end
    f.close()
end