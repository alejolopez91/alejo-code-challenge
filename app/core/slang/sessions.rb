module Slang
  class Sessions
    attr_reader :provider

    def initialize(provider: Slang::Activities.new)
      @provider = provider
    end

    def sort_sessions
      raw_data = provider.get_activities
      sorted_data = process_data(raw_data["activities"])
    end

    private

    def process_data(data)
      grouped_data = group_by_id(data)
      ordered_data = order_in_sessions_data(grouped_data)

      { "user_sessions": ordered_data }
    end

    def group_by_id(data)
      dict = {}
      data.each do |element|
        data_obj = dict[element["user_id"]] || first_element(element["user_id"])
        data_obj["answered_at"].push(Time.parse(element["answered_at"]))
        data_obj["first_seen_at"].push(Time.parse(  element["first_seen_at"]))
        data_obj["activity_ids"].push(element["id"])
        dict[element["user_id"]] = data_obj
      end

      dict
    end

    def order_data(data)
      data.map do |id, element|
        first_date = element["first_seen_at"].min
        last_date = element["answered_at"].max
        element["first_seen_at"] = first_date
        element["answered_at"] = last_date
        element["duration_seconds"] = (first_date - last_date) / 1
        
        element
      end
    end

    def first_element(user_id)
      {  
        "answered_at": [],
        "first_seen_at": [],
        "activity_ids": [],
        "duration_seconds": ""
      }.with_indifferent_access
    end
  end
end
