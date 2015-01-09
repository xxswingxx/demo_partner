module ApplicationHelper

  def foundation_type(type)
    case type
      when 'warning' then 'warning round'
      when 'alert' then 'alert round'
      when 'notice' then 'success round'
      when 'info' then 'secondary round'
      else nil
    end
  end
end
