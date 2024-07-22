class OrderService
    def self.create(request)
        Order.transaction do
            Order.with_advisory_lock("order_create") do                      
                order = Order.create(request)
                
                max_batch_no = Order.maximum(:batch_no) || 1
                print("Max batch no: #{max_batch_no}")

                quantity_in_batch = Order.where(batch_no: max_batch_no).count
                print("Orders in batch: #{quantity_in_batch}")

                sleep(AlRuby::Application.config.sleep_time)
                
                batch_no = quantity_in_batch > 3 ? max_batch_no+1 : max_batch_no

                print("Updating order - max:#{max_batch_no} current:#{quantity_in_batch} batch_no: #{batch_no}")
                order.update(batch_no: batch_no)
            end
        end
    end

    def self.print(message)
        puts "#{Time.now} #{Process.pid}: #{message}"
    end
end
