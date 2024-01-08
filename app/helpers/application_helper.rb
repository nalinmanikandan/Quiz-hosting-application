module ApplicationHelper
  include Pagy::Frontend
  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder |
      render(association.to_s.singularize + "_form", ff: builder)
    end
    hidden_field_tag "tag_field_data", fields.gsub("\n",""), id:'tag_field_data'
    hidden_field_tag "tag_id_data", id, id:'tag_id_data'
    link_to(name, '#', class:"add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n","")})
  end
  def tag_id_data(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    hidden_field_tag "tag_id_data", id, id:'tag_id_data'
  end
  def tag_field_data(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder |
      render(association.to_s.singularize + "_form", ff: builder)
    end
    hidden_field_tag "tag_field_data", fields.gsub("\n",""), id:'tag_field_data'
  end
end
