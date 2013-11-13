# encoding: UTF-8
module RubyGolf

  ##############################################################################
  # Hole 1: RubyGolf.x_out_numbers                                             #
  ##############################################################################
  # input:  n - numbers string to be x'ed out,
  #         v - number of visible trailing numbers
  # output: x'ed out string
  def self.x_out_numbers(n, v)
    p = (n.length - v)
    p>0 ? n.gsub(/\d{#{p}}/, 'x' * p) : n
  end


  ##############################################################################
  # Hole 2: RubyGolf.underscore                                                #
  ##############################################################################
  # input:  an identifier string in camel case notation. i.e. 'SchinkenWurst'
  # ouput:  a 'ruby style' version of the identifier: all lowercase, former case
  #         changes to upper case get a prepended underscore
  def self.underscore(s)
    s.gsub(/([a-z])-*([A-Z])/, '\1_\2').downcase
  end


  ##############################################################################
  # Hole 3: RubyGolf.symbolize_keys                                            #
  ##############################################################################
  # input:  a hash
  # output: a hash where each key is a symbol.
  #         The values stay the same except they're hashes too.
  #         Values that are hashes contain only smybols as keys too, this
  #         condition is maintained recursivley
  def self.symbolize_keys(h)
    return h if !h.is_a?(Hash)
    o={}
    h.each {|k,v| o[k.to_sym] = self.symbolize_keys(v)}
    o
  end


  ##############################################################################
  # Hole 4: RubyGolf.grid_computing                                            #
  ##############################################################################
  # input:  a grid of numbers between 00 and 99, separated by spaces, each row
  #         ending in a \n
  # output: the maximum value found by calculating the sums of all rows and
  #         columns
  
  def self.grid_computing(g)
    a = g.split("\n").map{|s| s.split(" ")}
    (a + a.transpose).inject(0) {|y,l| 
      s=l.inject(0){|m,n| m+n.to_i}
      s>y ? s : y
    }
  end


  ##############################################################################
  # Hole 5: RubyGolf.reformat_hash                                             #
  ##############################################################################
  # input:  a string containing a hash expression possibly containing hash
  #         rockets
  # output: a string describing the same hash but without hash rockets, but
  #         otherwise with the same formatting
  def self.reformat_hash(s)
    s.gsub(/:{1}([a-z]+):{0} \=\>/, '\1:')
  end


  ##############################################################################
  # Hole 6: RubyGolf.pretty_hash                                               #
  ##############################################################################
  # input:  a recursive hash mapping of strings or symbols ultimately to lists
  #         of strings or symbols
  # output: a formatted string containing the information of the hash where:
  #         * every line contains exactly one key or value
  #         * values are prefixed by a hyphen and a space
  #         * keys a suffixed with a colon
  #         * all keys or values that are contained in a hash that is not top
  #           level are prepended by two additional spaces per level away from
  #           the top level
  def self.pretty_hash(h, d=0)
    a = h.map{|k,v| (" " * d) + k.to_s + ":\n" + (v.is_a?(Hash) ? pretty_hash(v,d+2) : [v].flatten.map{|a| (" " * d) + "- " + "#{a}" + "\n"}.join())}.join()
  end


  ##############################################################################
  # Hole 7: RubyGolf.word_letter_sum                                           #
  ##############################################################################
  # input:  a string containing a list of space separated, letter-only words
  # output: independent of the case of the characters of the words the following
  #         value is calculated:
  #         * take the sum of the alphabetical positions of the characters of a
  #           word (A=1, B=2..)
  #         * sort the words by that sum - the one with the largest sum will be
  #           the first
  #         * multiply each sum with the position of its word in the list (first
  #           word 1* ...)
  #         * sum all products
  def self.word_letter_sum(s)
    x = 0
    s.upcase.split().map{|w|
      w.each_char.inject(0) {|m,c| m + (c.ord - 64) }
    }.sort.reverse.each_with_index{|w , i| x += (i + 1) * w }
    x
  end


  ##############################################################################
  # Hole 8: RubyGolf.bob_ross                                                  #
  ##############################################################################
  # input:  a string defining an image, each line consisting of three values:
  #         * x coordinate
  #         * y coordinate
  #         * ascii value for that coordinate
  # output: an ascii art string ready for output where there aren't any trailing
  #         spaces after the last character in each line
  def self.bob_ross(s)
    b=[]
    a=s.split(/\n/).map{|l| l.split(" ")}
    a.map{|c| 
      x,y,z = c
      b[y.to_i] ||= []
      b[y.to_i][x.to_i] = z.to_i
    }
    b.map{|l| l.map{ |c| c ? c.chr : ' '}.join.rstrip + "\n"}.join
    
  end

end
