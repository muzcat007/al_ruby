class OrderEventDjJob < ActiveJob::Base
    def perform(request)
        OrderService.create(request)
    end
end