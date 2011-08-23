module Stats
  module Helpers
    def self.identity
      lambda {|x| x }
    end

    def self.zipmap(values, &f)
      Hash[*values.zip(values.map &f).flatten]
    end

    def self.rank_map(values)
      Hash[*values.zip(ranks_for values).flatten]
    end

    def self.ranks_for(values, partition=true)
      if partition
        ranks_for(values.group_by(&identity).values, false)
      else
        ranks = []
        curr_rank = 1

        # I despise using #each where pure functions would do, but clarity is king,
        # and intermingling state with a loop is probably best done this way,
        # at least in Ruby. In Clojure this would be a list comprehension.
        values.each do |n|
          curr_len = n.is_a?(Fixnum) ? 1 : n.length

          new_ranks = average_ranks(curr_rank, curr_len)
          curr_rank += curr_len

          ranks << new_ranks
        end

        ranks.flatten
      end
    end

    def self.average_ranks(starting_rank, length)
      endpoint = starting_rank + length
      rank_sum = Math.sum(starting_rank...endpoint)
      tie_avg = rank_sum / length.to_f

      [tie_avg] * length
    end

    def self.tie_correct(rank_vals)
      n = rank_vals.length
      ties = partition_ties(rank_vals)
      num_ties = ties.values

      t = num_ties.reduce(0) {|mem, x| mem + (x ** 3) - x }

      1.0 - t / (n ** 3 - n)
    end

    def self.partition_ties(values)
      counts = values.sort.group_by(&identity).
        map {|pair| [pair[0], pair[1].length] }.flatten

      Hash[*counts]
    end
  end
end
