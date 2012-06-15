module Bandit
  class EpsilonDecreasingPlayer < BasePlayer
    include Memoizable

    def choose_alternative(experiment)
      epsilon = @config['epsilon'].to_f || 0.1

      total_days = @config['epsilon_decreasing_time'] || 10
      day_count = Date.today - experiment.start_time

      if rand <= (1-epsilon) * (day_count/total_days)
        best_alternative(experiment)
      else
        experiment.alternatives.sample
      end
    end

    def best_alternative(experiment)
      memoize(experiment.name) { 
        best = nil
        best_rate = nil
        experiment.alternatives.each { |alt|
          rate = experiment.conversion_rate(alt)
          if best_rate.nil? or rate > best_rate
            best = alt
            best_rate = rate
          end
        }
        best
      }
    end
  end
end
