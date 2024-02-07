# This script Scales or Rotates multiple sketchup components about their respective centers

require "sketchup.rb"

def scale_rotate()
    choice = UI.messagebox("Choose an operation: Yes = Scale, No = Rotate", MB_YESNO, "Choose an operation") do |msg|
        msg.buttons = [ "Scale", "Rotate" ]
    end
    
    case choice
    when IDYES  # Scale
        scale_factor = UI.inputbox(["Scale Factor"], [2.0], "Enter the scale factor")[0]
    
        # Scale the selected objects
        selection = Sketchup.active_model.selection
        selection.each do |entity|
        center = entity.bounds.center
        transformation = Geom::Transformation.scaling(center, scale_factor.to_f)
        entity.transform!(transformation)
        end
    when IDNO   # Rotate
        rotation_angle = UI.inputbox(["Rotation Angle"], [45], "Enter the rotation angle")[0].to_f
    
        # Rotate the selected objects
        selection = Sketchup.active_model.selection
        selection.each do |entity|
        center = entity.bounds.center
        transformation = Geom::Transformation.rotation(center, [0,0,1], rotation_angle.degrees)
        entity.transform!(transformation)
        end
    end
end

UI.menu("Extensions").add_item("Scale/Rotate Selection Individually") {
  scale_rotate()
}
