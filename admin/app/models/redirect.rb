class Redirect < ApplicationRecord
  scope :user_ordered, -> { order(order: :asc) }

  def self.max_order
    order(order: :desc).limit(1).pluck(:order).first || 1
  end

  def reorder_up
    other_redirect = Redirect.where('redirects.order < ?', order).order(order: :desc).first
    # if there are no other redirects with a lower order number assume success
    other_redirect.nil? || swap_orders(other_redirect)
  end

  def reorder_down
    other_redirect = Redirect.where('redirects.order > ?', order).order(order: :asc).first
    # if there are no other redirects with a lower order number assume success
    other_redirect.nil? || swap_orders(other_redirect)
  end

  # swap order value for redirects
  def swap_orders(other_redirect)
    new_order = other_redirect.order
    other_order = order
    self.transaction do
      update(order: 0)
      other_redirect.update(order: other_order)
      update(order: new_order)
    end
    true
  rescue => e
    Rails.logger.info(e)
    false
  end

end
