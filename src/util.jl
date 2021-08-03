
import CImGui.LibCImGui:
    GetPlotMousePos,
    GetPlotLimits,
    GetPlotQuery,
    GetLastItemColor,
    NextColormapColor
    
function SetNextPlotTicksX(values::Vector{<:Real}, n_ticks::Integer,
                           labels = [""], show_default::Bool = false)

    eltype(values) !== Float64 && (values = Float64.(values))

    ImPlot_SetNextPlotTicksXdoublePtr(values, Cint(n_ticks), labels, show_default) 
end

function SetNextPlotTicksX(x_min, x_max, n_ticks::Integer,
                           labels = [""], show_default::Bool = false)
    
    typeof(x_min) !== Float64 && (x_min = Float64(x_min))
    typeof(x_max) !== Float64 && (x_max = Float64(x_max))

    ImPlot_SetNextPlotTicksXdouble(x_min, x_max, Cint(n_ticks), labels, show_default)
end

function SetNextPlotTicksY(values::Vector{<:Real}, n_ticks::Integer,
                           labels = [""], show_default::Bool = false,
                           y_axis::Integer = 0)

    eltype(values) !== Float64 && (values = Float64.(values))

    ImPlot_SetNextPlotTicksYdoublePtr(values, Cint(n_ticks), labels, show_default,
                                          Cint(y_axis))
end

function SetNextPlotTicksY(y_min, y_max, n_ticks::Integer,
                           labels = [""], show_default::Bool = false,
                           y_axis::Integer = 0)

    typeof(y_min) !== Float64 && (y_min = Float64(y_min))
    typeof(y_max) !== Float64 && (y_max = Float64(y_max))

    ImPlot_SetNextPlotTicksYdouble(y_min, y_max, Cint(n_ticks), labels, show_default,
                                       Cint(y_axis))
end

function GetPlotPos()
    out = Ref{ImVec2}()
    ImPlot_GetPlotPos(out)
    return out[]
end

function GetPlotSize()
    out = Ref{ImVec2}()
    ImPlot_GetPlotSize(out)
    return out[]
end

SetLegendLocation(location, orientation) = ImPlot_SetLegendLocation(location, orientation, false)
SetLegendLocation(location) = ImPlot_SetLegendLocation(location, ImPlot_ImPlotOrientation_Vertical, false)

# ImPlot_SetNextPlotLimits(xmin, xmax, ymin, ymax) = ImPlot_SetNextPlotLimits(xmin, xmax, ymin, ymax, ImGuiCond_Once)
SetNextPlotLimits(xmin, xmax, ymin, ymax, cond=ImGuiCond_Once) = ImPlot_SetNextPlotLimits(xmin, xmax, ymin, ymax, cond)


function PixelsToPlot(pix::ImVec2, y_axis = IMPLOT_AUTO)
    out = Ref(ImPlotPoint())
    ImPlot_PixelsToPlotVec2(out, pix, y_axis)
    return out[]
end

function PixelsToPlot(x::Real, y::Real, y_axis = IMPLOT_AUTO)
    out = Ref(ImPlotPoint())
    ImPlot_PixelsToPlotFloat(out, x, y, y_axis)
    return out[]
end
function PlotToPixels(plt::ImPlotPoint, y_axis = IMPLOT_AUTO)
    out = Ref{ImVec2}()
    ImPlot_PlotToPixelsPlotPoInt(out, plt, y_axis)
    return out[]
end
function PlotToPixels(x::Real, y::Real, y_axis = IMPLOT_AUTO)
    out = Ref{ImVec2}()
    ImPlot_PlotToPixelsdouble(out, x, y, y_axis)
    return out[]
end

function ImPlot_GetPlotMousePos(y_axis = IMPLOT_AUTO)
    out = Ref(ImPlotPoint())
    ImPlot_GetPlotMousePos(out, y_axis)
    return out[]
end

function ImPlot_GetPlotLimits(y_axis = IMPLOT_AUTO)
    out = Ref(ImPlotLimits())
    ImPlot_GetPlotLimits(out, y_axis)
    return out[]
end

function ImPlot_GetPlotQuery(y_axis = IMPLOT_AUTO)
    out = Ref(ImPlotLimits())
    ImPlot_GetPlotQuery(out, y_axis)
    return out[]
end

function ImPlot_GetLastItemColor()
    out = Ref{ImVec4}()
    ImPlot_GetLastItemColor(out)
    return out[]
end
function ImPlot_GetColormapColor(index)
    out = Ref{ImVec4}()
    ImPlot_GetColormapColor(out, index)
    return out[]
end
function ImPlot_LerpColormap(t)
    out = Ref{ImVec4}()
    ImPlot_LerpColormap(out, t)
    return out[]
end
function ImPlot_NextColormapColor()
    out = Ref{ImVec4}()
    ImPlot_NextColormapColor(out)
    return out[]
end

# function Contains(range::ImPlot_ImPlotRange, value)
#     return value >= range.Min && value <= range.Max
# end
# function Contains(limits::ImPlot_ImPlotLimits, x, y)
#     return Contains(limits.X, x) && Contains(limits.Y, y)
# end
# function Contains(limits::ImPlot_ImPlotLimits, p::ImPlot_ImPlotPoint)
#     return Contains(limits.X, p.x) && Contains(limits.Y, p.y)
# end

function DragLineX(id::String, x_value, show_label::Bool = true, col::ImVec4 = IMPLOT_AUTO_COL, thickness::Real = 1)
    ImPlot_DragLineX(id, x_value, show_label, col, thickness)
end

function DragLineY(id::String, y_value, show_label::Bool = true, col::ImVec4 = IMPLOT_AUTO_COL, thickness::Real = 1)
    ImPlot_DragLineY(id, y_value, show_label, col, thickness)
end

function DragPoint(id::String, x, y, show_label::Bool = true, col::ImVec4 = IMPLOT_AUTO_COL, radius::Real = 4)
    ImPlot_DragPoint(id, x, y, show_label, col, radius)
end

SetNextLineStyle(col = IMPLOT_AUTO_COL, weight = IMPLOT_AUTO)  = ImPlot_SetNextLineStyle(col,weight)
SetNextFillStyle(col = IMPLOT_AUTO_COL, alpha_mod = IMPLOT_AUTO) = ImPlot_SetNextFillStyle(col, alpha_mod)
SetNextMarkerStyle(marker = IMPLOT_AUTO, size = IMPLOT_AUTO, fill = IMPLOT_AUTO_COL, weight = IMPLOT_AUTO, outline = IMPLOT_AUTO_COL) = ImPlot_SetNextMarkerStyle(marker, size, fill, weight, outline)
SetNextErrorBarStyle(col = IMPLOT_AUTO_COL, size = IMPLOT_AUTO, weight = IMPLOT_AUTO) = ImPlot_SetNextErrorBarStyle(col, size, weight)

