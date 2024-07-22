require 'sidekiq'
 
class OrderEventSkJob
  include Sidekiq::Job
 
  def perform(request)
    OrderService.create(request)
  end
end