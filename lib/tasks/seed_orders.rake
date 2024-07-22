
desc "create orders"
task :seed_orders_dj, [:count] => [:environment] do |t, args|
    args[:count].to_i.times do |index|
        puts "Createing order event #{index}"
        OrderEventDjJob.perform_later({
            line_item_count: rand(1..10),
            company_name: "Customer #{rand(1..5)}"
        })
    end
end

task :seed_orders_sk, [:count] => [:environment] do |t, args|
    args[:count].to_i.times do |index|
        puts "Createing order event #{index}"
        OrderEventSkJob.perform_async({
            "line_item_count" => rand(1..10),
            "company_name" => "Customer #{rand(1..5)}"
        })
    end
end  