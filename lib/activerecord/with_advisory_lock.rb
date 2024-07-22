require 'active_support/concern'

module WithAdvisoryLock
    extend ActiveSupport::Concern

    class_methods do
        def with_advisory_lock(name, &block)
            lock_id = Digest::MD5.hexdigest(name).to_i(16)
            puts "#{Time.now} #{Process.pid}: lock #{lock_id}"
            connection.execute("SELECT pg_advisory_xact_lock(#{lock_id})")
            begin
                block.call
            ensure
                # connection.execute("SELECT pg_advisory_unlock(#{lock_id})")
            end        
        end
    end
end

ActiveRecord::Base.send(:include, WithAdvisoryLock)