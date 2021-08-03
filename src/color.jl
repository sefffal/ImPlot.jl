# Color mapping

# import .ImPlot_GetColormapSize

# function SetColormap(colormap, samples::Integer = 1)
#     ImPlot_SetColormapPlotColormap(colormap, Cint(samples))
# end

# function SetColormap(colors::ImVec4, num_colors::Integer)
#     ImPlot_SetColormapVec4Ptr(colors, Cint(num_colors))
# end

# function GetColormapColor(index::Integer)
#     out = Ref{ImVec4}()
#     ImPlot_GetColormapColor(out, Cint(index))
#     return out[]
# end

# function LerpColormap(t::Integer)
#     out = Ref{ImVec4}()
#     ImPlot_LerpColormap(out, Cint(t))
#     return out[]
# end

# function PushColormap(colormap)
#     ImPlot_PushColormapPlotColormap(colormap)
# end

# function PushColormap(colormap::Vector{ImVec4}, size::Integer)
#     ImPlot_PushColormapVec4Ptr(colormap, size)
# end

function PopColormap(count::Integer = 1)
    ImPlot_PopColormap(count)
end


function PushColormap(colormap::ImPlot.ImPlotColormap_)
    PushColormap_PlotColormap(colormap)
end
function PushColormap(colormap::AbstractString)
    PushColormap_Str(colormap)
end