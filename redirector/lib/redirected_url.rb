class RedirectedUrl
  def initialize(opts = {})
    options = opts || {}
    @code = options[:code]
    @regex = Regexp.new(options[:regex])
    @result = options[:result]
  end

  attr_reader :code

  def match?(url)
    @regex.match? url
  end

  # TODO: allow match captures to be used in result url
  def result_url
    @result
  end
end
