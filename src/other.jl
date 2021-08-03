# Plot text labels at arbitrary coordinate points
function PlotText(text::String, x::Real, y::Real, vertical::Bool = false,
                  pixel_offset::ImVec2 = ImVec2(0,0))
    ImPlot_PlotText(text, x, y, vertical, pixel_offset)
end

function PlotImage(
    user_texture_id, 
    bounds_min::ImPlotPoint = (0,0),
    bounds_max::ImPlotPoint = (0,0),
    uv0::ImVec2 = (0,0), 
    uv1::ImVec2=(1,1), 
    tint_col::ImVec4=(1,1,1,1);
    label_id::String = ""
)
    ImPlot_PlotImage(label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1, tint_col)
end

function PlotImage(
    label_id::String,
    user_texture_id, 
    bounds_min::ImPlotPoint = (0,0),
    bounds_max::ImPlotPoint = (0,0),
    uv0::ImVec2 = (0,0), 
    uv1::ImVec2=(1,1), 
    tint_col::ImVec4=(1,1,1,1)
)
    ImPlot_PlotImage(label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1, tint_col)
end
