
require "sketchup.rb"

def scale_rotate()
    operation = UI.inputbox(["Enter 'S' for Scale or 'R' for Rotate"], ["S"], "Choose an operation")[0].upcase
   
    case operation
    when 'S'  # Scale
        scale_factor = UI.inputbox(["Scale Factor"], [2.0], "Enter the scale factor")[0]
   
        # Scale the selected objects
        selection = Sketchup.active_model.selection
        selection.each do |entity|
            center = entity.bounds.center
            transformation = Geom::Transformation.scaling(center, scale_factor.to_f)
            entity.transform!(transformation)
        end
    when 'R'   # Rotate
        rotation_angle = UI.inputbox(["Rotation Angle"], [45], "Enter the rotation angle")[0].to_f
   
        # Rotate the selected objects
        selection = Sketchup.active_model.selection
        selection.each do |entity|
            center = entity.bounds.center
            transformation = Geom::Transformation.rotation(center, [0,0,1], rotation_angle.degrees)
            entity.transform!(transformation)
        end
    else
        UI.messagebox("Invalid input. Please enter 'S' for Scale or 'R' for Rotate.")
    end
end

if UI.messagebox("Add the extension to the menu?", MB_YESNO) == IDYES
    UI.menu("Extensions").add_item("Scale/Rotate Selection Individually") {
        scale_rotate()
    }
end