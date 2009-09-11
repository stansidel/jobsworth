# A chat message in a chat channel

class Shout < ActiveRecord::Base
  belongs_to :shout_channel
  belongs_to :company
  belongs_to :user

  def self.full_text_search(q, options = {})
    return nil if q.nil? or q==""
    default_options = {:limit => 20, :page => 1}
    options = default_options.merge options
    options[:offset] = options[:limit] * (options.delete(:page).to_i-1)
    results = WorkLog.find_with_ferret(q, options)
    return [results.total_hits, results]
  end

end
