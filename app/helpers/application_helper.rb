module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice' then 'alert-success'
    when 'success' then 'alert-success'
    when 'alert' then 'alert-danger'
    else 'alert-info'
    end
  end

  def get_accessible_table_names
    all_model_names.sort
  end

  private

  def all_model_names
    all_models = ActiveRecord::Base.descendants.reject do |model|
      model.abstract_class? || model.name.include?('ActiveRecord::')
    end
  
    all_model_names = Set.new
  
    all_models.each do |model|
      all_model_names << model.name
  
      model.reflect_on_all_associations.each do |association|
        if association.macro == :has_many || association.macro == :has_one
          associated_model_name = association.class_name
          all_model_names << associated_model_name
        end
      end
    end
  
    all_model_names.to_a
  end
end
