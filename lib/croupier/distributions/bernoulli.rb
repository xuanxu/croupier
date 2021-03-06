module Croupier
  module Distributions

    #####################################################################
    # Bernoulli Distribution
    # Discrete probability distribution taking value 1 with success
    # probability p and value 0 with failure probability 1-p
    # Equivalent to a Binomial(1,p)
    class Bernoulli < ::Croupier::Distribution

      distribution_name "Bernoulli distribution"
      distribution_description "Discrete probability distribution taking value 1 with success probability p and value 0 with failure probability 1-p."

      cli_name "bernoulli"

      cli_option :success, 'success probability', {type: :float, short: "-p", default: 0.5}

      cli_banner "Bernoulli distribution. Discrete probability distribution taking value 1 with success probability p and value 0 with failure probability 1-p."


      enumerator do |c|
        c.binomial(success: success, size: 1).to_enum
      end

      def initialize(options={})
        super(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
      end
    end
  end
end
