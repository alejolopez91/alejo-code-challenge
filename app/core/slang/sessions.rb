module Slang
  class Sessions
    attr_reader :provider

    def initialize(provider: Slang::Activities.new)
      @provider = provider
    end

    def sort_sessions
      raw_data = provider.get_activities
      process_data(raw_data["activities"])
    end

    private

    def process_data(data)
      grouped_data = group_by_user_id(data)
      sorted_dates = grouped_data.map do |id, activities|
        sorted = sort_date(activities)
        { "#{id}": divide_sessions(sorted) }.with_indifferent_access
      end
    end

    def group_by_user_id(data)
      data.group_by{ |element| element["user_id"].itself }
    end

    def sort_date(activities)
      activities.each do |activity|
        activity["first_seen_at"] = Time.parse(activity["first_seen_at"])
        activity["answered_at"] = Time.parse(activity["answered_at"])
      end
    end

    def divide_sessions(activities)
      list = []
      activities.each do |activity|
        if list.blank?
          list << new_first_element(activity)
          next 
        end

        session_obj = list.last
        if minutes_between_activities(session_obj, activity) < 5
          session_obj["ended_at"] = activity["answered_at"]
          session_obj["activity_ids"] << activity["id"]
          session_obj["duration_seconds"] = seconds_between_dates(session_obj)
          list[-1] = session_obj
        else
          list.last["duration_seconds"] = seconds_between_dates(session_obj)
          list.push(new_first_element(activity))
        end
      end

      list
    end

    def minutes_between_activities(session_obj, last_activity)
      (last_activity["first_seen_at"] - session_obj["ended_at"]) / 1.minute
    end

    def seconds_between_dates(session_obj)
      (session_obj["ended_at"] - session_obj["started_at"])
    end

    def new_first_element(activity)
      {  
        "ended_at": activity["answered_at"],
        "started_at": activity["first_seen_at"],
        "activity_ids": [activity["id"]],
        "duration_seconds": activity["answered_at"] - activity["first_seen_at"]
      }.with_indifferent_access
    end
  end
end
