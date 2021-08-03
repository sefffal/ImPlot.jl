module ImPlot

using CImGui
import CImGui: ImVec2, ImVec4

for i in instances(CImGui.ImGuiCond_)
    @eval import CImGui.LibCImGui: $(Symbol(i))
end



# include("ImPlot_jl")

# using .LibCImPlot
using CImGui.LibCImGui
export IMPLOT_AUTO, IMPLOT_AUTO_COL
export ImPlotPoint, ImPlotRange, ImPlotLimits

const ImPlotData = Union{Float32, Float64, Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64}
const IMPLOT_ENUMS = [ImPlotFlags_, ImPlotAxisFlags_, ImPlotCol_, ImPlotStyleVar_, ImPlotMarker_,
          ImPlotColormap_, ImPlotLocation_, ImPlotOrientation_, ImPlotYAxis_]

LibCImPlot = LibCImGui

# SKIPLIST = [
#     :ImPlot_BeginPlot
#     :ImPlot_PlotText
#     :ImPlot_PlotLineG
#     :ImPlot_PlotScatterG
#     :ImPlot_PlotShadedG
#     :ImPlot_PlotBarsG
#     :ImPlot_PlotBarsHG
#     :ImPlot_PlotDigitalG
#     :ImPlot_PlotBars
#     :ImPlot_PlotBarsH
#     :ImPlot_PlotDigital
#     :ImPlot_PlotErrorBars
#     :ImPlot_PlotHeatmap
#     :ImPlot_PlotLine
#     :ImPlot_PlotScatter
#     :ImPlot_PlotStairs
#     :ImPlot_PlotShaded
#     :ImPlot_PlotBars
#     :ImPlot_PlotErrorBars
#     :ImPlot_PlotErrorBarsH
#     :ImPlot_PlotStems
#     :ImPlot_PlotPieChart
#     :ImPlot_PlotDigital
#     :ImPlot_PlotImage
#     :ImPlot_PlotLine
#     :ImPlot_PlotShaded

#     :ImPlot_GetPlotPos
#     :ImPlot_GetPlotSize
#     :ImPlot_SetLegendLocation
#     :ImPlot_GetNextPlotLimits
#     :ImPlot_GetPlotLimits
#     :ImPlot_SetNextPlotLimits
#     :ImPlot_SetPlotLimits
#     :ImPlot_GetPlotMousePos
# ]
# for name in filter(startswith("ImPlot_"), string.(propertynames(LibCImGui)))
#     lhs = Symbol(replace(name, "ImPlot_"=>""))
#     rhs = Symbol(name)
#     if rhs in SKIPLIST
#         continue
#     end
#     @eval $lhs = $rhs
# end
        

# Export plot flags
for i in IMPLOT_ENUMS
    for j in instances(i)
        @eval export $(Symbol(j))
    end
end

function BeginPlot(title_id::String, x_label = C_NULL, y_label = C_NULL, size::ImVec2 = ImVec2(-1,0);
                    flags = ImPlotFlags_None,
                    x_flags = ImPlotAxisFlags_None,
                    y_flags = ImPlotAxisFlags_None,
                    y2_flags = ImPlotAxisFlags_None,
                    y3_flags = ImPlotAxisFlags_None,
                    y2_label = C_NULL,
                    y3_label = C_NULL,
                    )::Bool

    ImPlot_BeginPlot(title_id, x_label, y_label, size,
                         flags, x_flags, y_flags, y2_flags, y3_flags, y2_label, y3_label)
end


include("constructors.jl")
include("lines.jl")
include("stairs.jl")
include("shaded.jl")
include("scatter.jl")
include("heatmap.jl")
include("digital.jl")
include("barchart.jl")
include("piechart.jl")
include("errorbars.jl")
include("stems.jl")
include("other.jl")
include("util.jl")
include("color.jl")
include("styling.jl")




# SKIPLIST = [
#     :ImPlot_BeginPlot
#     :ImPlot_PlotText
#     :ImPlot_PlotLineG
#     :ImPlot_PlotScatterG
#     :ImPlot_PlotShadedG
#     :ImPlot_PlotBarsG
#     :ImPlot_PlotBarsHG
#     :ImPlot_PlotDigitalG
#     :ImPlot_PlotBars
#     :ImPlot_PlotBarsH
#     :ImPlot_PlotDigital
#     :ImPlot_PlotErrorBars
#     :ImPlot_PlotHeatmap
#     :ImPlot_PlotLine
#     :ImPlot_PlotScatter
#     :ImPlot_PlotStairs
#     :ImPlot_PlotShaded
#     :ImPlot_PlotBars
#     :ImPlot_PlotErrorBars
#     :ImPlot_PlotErrorBarsH
#     :ImPlot_PlotStems
#     :ImPlot_PlotPieChart
#     :ImPlot_PlotDigital
#     :ImPlot_PlotImage
#     :ImPlot_PlotLine
#     :ImPlot_PlotShaded

#     :ImPlot_GetPlotPos
#     :ImPlot_GetPlotSize
#     :ImPlot_SetLegendLocation
#     :ImPlot_GetNextPlotLimits
#     :ImPlot_GetPlotLimits
#     :ImPlot_SetNextPlotLimits
#     :ImPlot_SetPlotLimits
#     :ImPlot_GetPlotMousePos
# ]
for name in filter(startswith("ImPlot_"), string.(propertynames(LibCImGui)))
    lhs = Symbol(replace(name, "ImPlot_"=>""))
    rhs = Symbol(name)
    # if rhs in SKIPLIST
    #     continue
    # end
    try
        @eval $lhs = $rhs
    catch err
        continue
    end
end

end # module
