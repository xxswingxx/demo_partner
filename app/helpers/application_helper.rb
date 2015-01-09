module ApplicationHelper

  def foundation_type(type)
    case type
      when :warning then 'warning'
      when :alert then 'alert'
      when :notice then 'success'
      when :info then 'secondary'
      else nil
    end
  end
end
