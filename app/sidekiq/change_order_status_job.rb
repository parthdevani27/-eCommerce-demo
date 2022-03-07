class ChangeOrderStatusJob
  include Sidekiq::Job

  def perform(*args)
    @orders = Order.where.not(status: ['complete','cancelled','declined','refunded'])
    @orders.each do |order|
      if order.status == 'pending'
        order.status = 'awaiting_payment' 
      end
      @timd_diff = (Time.zone.now.to_date  - (order.created_at.to_date)).to_i
      if @timd_diff >= 0 && @timd_diff <= 1
        order.status = 'awaiting_shipment'
      elsif @timd_diff > 1 && @timd_diff <= 2
        order.status = 'awaiting_pickup'
      elsif @timd_diff > 2 && @timd_diff <= 3
        order.status = 'awaiting_shipped'
      elsif @timd_diff > 3 && @timd_diff <= 4
        order.status = 'shipped'
      elsif @timd_diff < 0    
        order.status = 'declined'
      else
        order.status = 'complete'  
      end
          
      order.save()
    end
  end
end
