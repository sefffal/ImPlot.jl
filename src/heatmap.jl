#Heatmap plots

function PlotHeatmap(label_id, x::AbstractArray{T}, rows::Integer, cols::Integer, scale_min::Real = 0., scale_max::Real = 0., label_fmt::String = "&.1f", bounds_min = ImPlot_ImPlotPoint(0.0,0.0),
                 bounds_max = ImPlot_ImPlotPoint(1.0,1.0)) where {T<:ImPlotData}
     ImPlot_PlotHeatmap(label_id, x, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end
   
function PlotHeatmap(label_id, x::AbstractArray{T}, rows::Integer, cols::Integer, scale_min::Real = 0., scale_max::Real = 0., label_fmt::String = "&.1f", bounds_min = ImPlot_ImPlotPoint(0.0,0.0),
                 bounds_max = ImPlot_ImPlotPoint(1.0,1.0)) where {T<:Float64}
    ImPlot_PlotHeatmap(label_id, Float64.(x), rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end
 

function PlotHeatmap(x::AbstractArray{T}, rows, cols, scale_min = 0.0, scale_max = 1.0;
                 label_id::String = "", label_fmt=C_NULL, bounds_min = ImPlot_ImPlotPoint(0.0,0.0),
                 bounds_max = ImPlot_ImPlotPoint(1.0,1.0)) where {T<:ImPlotData}

    ImPlot_PlotHeatmap(label_id, x, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

heatmap_functions = [
    Int16 => LibCImGui.ImPlot_PlotHeatmap_S16Ptr,
    Int32 => LibCImGui.ImPlot_PlotHeatmap_S32Ptr,
    Int64 => LibCImGui.ImPlot_PlotHeatmap_S64Ptr,
    UInt16 => LibCImGui.ImPlot_PlotHeatmap_U16Ptr,
    UInt32 => LibCImGui.ImPlot_PlotHeatmap_U32Ptr,
    UInt64 => LibCImGui.ImPlot_PlotHeatmap_U64Ptr,
    Cfloat => LibCImGui.ImPlot_PlotHeatmap_FloatPtr,
    Cdouble => LibCImGui.ImPlot_PlotHeatmap_doublePtr,
]
for (type, func) in heatmap_functions
    @eval ImPlot_PlotHeatmap(label_id, x::AbstractArray{<:$type}, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max) = $func(label_id, x, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

