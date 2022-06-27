# frozen_string_literal: true

module Auth
  class Base
    attr_accessor :controller, :params

    def self.call(controller, params)
      new(controller, params).run
    end

    def initialize(controller, params)
      @controller = controller
      @params = params
    end

    def run
      raise NotImplementedError
    end

    private

    def request
      @request ||= controller.request
    end
  end
end
