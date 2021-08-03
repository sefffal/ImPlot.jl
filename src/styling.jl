# Utils for modifying plot style variables

function PushStyleColor(idx, col::UInt32)
    ImPlot_PushStyleColorU32(idx, col)
end

function PushStyleColor(idx, col::ImVec4)
    ImPlot_PushStyleColorVec4(idx, col)
end

function PushStyleVar(idx, val::AbstractFloat)
    ImPlot_PushStyleVarFloat(idx, Float32(val))
end

function PushStyleVar(idx, val::Integer)
    ImPlot_PushStyleVarInt(idx, Cint(val))
end

function PopStyleColor(count::Integer = 1)
    ImPlot_PopStyleColor(count)
end

function PopStyleVar(count::Integer = 1)
    ImPlot_PopStyleVar(count)
end
