# Line plots

function PlotLine(label_id, x::Union{AbstractArray{T},Ref{T},Ptr{T}}, y::Union{AbstractArray{T},Ref{T},Ptr{T}}, count::Integer=length(x), offset::Integer = 0, stride::Integer = sizeof(T)) where {T<:ImPlotData}
    ImPlot_PlotLine(label_id, x, y, count, offset, stride)
end

function PlotLine(label_id, x::Union{AbstractArray{T},Ref{T},Ptr{T}}, y::Union{AbstractArray{T},Ref{T},Ptr{T}}, count::Integer=length(x), offset::Integer = 0, stride::Integer = sizeof(Float64)) where {T<:Real}
    ImPlot_PlotLine(label_id, Float64.(x), Float64.(y), count, offset, stride)
end

function PlotLine(label_id, x::Union{AbstractArray{T},Ref{T},Ptr{T}}, count::Integer=length(x), xscale::Real = 1.0, x0::Real = 0.0, offset::Integer = 0, stride::Integer = sizeof(T)) where {T<:ImPlotData}
    ImPlot_PlotLine(label_id, x, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, x::Union{AbstractArray{T},Ref{T},Ptr{T}}, count::Integer=length(x), xscale::Real = 1.0, x0::Real = 0.0, offset::Integer = 0, stride::Integer = sizeof(Float64)) where {T<:Real}
    ImPlot_PlotLine(label_id, Float64.(x), count, xscale, x0, offset, stride)
end

function PlotLine(x::AbstractArray{T}, y::AbstractArray{T};
                  count::Integer = min(length(x), length(y)), offset::Integer = 0,
                  stride::Integer = 1, label_id::String = "") where {T<:ImPlotData}
    ImPlot_PlotLine(label_id, x, y, count, offset, stride * sizeof(T))
end

function PlotLine(x::AbstractArray{T1}, y::AbstractArray{T2}; kwargs...) where {T1<:Real, T2<:Real}
    PlotLine(promote(x,y)...; kwargs...)
end

function PlotLine(y::AbstractArray{T}; label_id::String="", count::Integer=length(y),
                  xscale::Real = 1.0, x0::Real = 0.0, offset::Integer=0,
                  stride::Integer=1) where {T<:ImPlotData}
    ImPlot_PlotLine(label_id, y, count, xscale, x0, offset, stride * sizeof(T))
end

function PlotLine(x::UnitRange{<:Integer}, y::AbstractArray{T}; xscale::Real = 1.0,
                  x0::Real = 0.0, label_id::String="") where {T<:ImPlotData}

    count::Cint = length(x) <= length(y) ? length(x) : throw("Range out of bounds")
    offset::Cint = x.start >= 1 ? x.start - 1 : throw("Range out of bounds")
    stride::Cint = sizeof(T)
    ImPlot_PlotLine(label_id, y, count,  xscale, x0, offset, stride)
end

function PlotLine(x::StepRange, y::AbstractArray{T}; xscale::Real = 1.0, x0::Real = 0.0,
                  label_id::String= "") where {T<:ImPlotData}

    x.stop < 1 && throw("Range out of bounds")
    count::Cint = length(x) <= length(y) ? length(x) : throw("Range out of bounds")
    offset::Cint = x.start >= 1 ? x.start - 1 : throw("Range out of bounds")
    stride = Cint(x.step * sizeof(T))
    ImPlot_PlotLine(label_id, y, count, xscale, x0, offset, stride)
end

PlotLine(x::UnitRange{<:Integer}, y::AbstractArray{<:Real}; kwargs...) = PlotLine(x, Float64.(y); kwargs...)
PlotLine(x::StepRange, y::AbstractArray{<:Real}; kwargs...) = PlotLine(x, Float64.(y); kwargs...)

# xfield, yfield should be propertynames of eltype(structvec)
function PlotLine(
    structvec::Vector{T}, xfield::Symbol, yfield::Symbol; 
    count::Integer = length(structvec), offset::Integer = 0,
    stride::Integer = 1, label_id::String = ""
) where T
    
    Tx = fieldtype(T, xfield)
    Ty = fieldtype(T, yfield)
    x_offset = fieldoffset(T, Base.fieldindex(T, xfield))
    y_offset = fieldoffset(T, Base.fieldindex(T, yfield))
    x_ptr = (pointer(structvec, 1) + x_offset) |> Ptr{Tx}
    y_ptr = (pointer(structvec, 1) + y_offset) |> Ptr{Ty} 

    if !T.mutable
        # this is somewhat illegal and is used only to pass a pointer through AbstractArray argument into ccall
        x = unsafe_wrap(Vector{Tx}, x_ptr, size(structvec); own = false)
        y = unsafe_wrap(Vector{Ty}, y_ptr, size(structvec); own = false)
        stride = stride * sizeof(T)
    else # two new vectors every 1/60 second...
        x = Vector{Tx}(undef, length(structvec))
        y = Vector{Ty}(undef, length(structvec))
        for (i, val) in enumerate(structvec)
            x[i] = getproperty(val, xfield)
            y[i] = getproperty(val, yfield)
        end
        if Tx !== Ty
            x, y = promote(x, y)
        end
        stride = stride * sizeof(eltype(x))
    end

    ImPlot_PlotLine(label_id, x, y, count, offset, stride)
end

PlotLineG(label_id, getter, data, count, offset = 0) =
ImPlot_PlotLineG(label_id, getter, data, count, offset)


AA = AbstractArray
line_functions = [
    (AA{<:Cfloat}, AA{<:Cfloat}) => ImPlot_PlotLine_FloatPtrFloatPtr
    (AA{<:Cdouble}, AA{<:Cdouble}) => ImPlot_PlotLine_doublePtrdoublePtr
    (AA{<:Int32}, AA{<:Int32}) => ImPlot_PlotLine_S32PtrS32Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_U16PtrInt
    (AA{<:UInt64}, AA{<:UInt64}) => ImPlot_PlotLine_U64PtrU64Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_FloatPtrInt
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_S64PtrInt
    (AA{<:UInt16}, AA{<:UInt16}) => ImPlot_PlotLine_U16PtrU16Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_U8PtrInt
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_S16PtrInt
    (AA{<:Int64}, AA{<:Int64}) => ImPlot_PlotLine_S64PtrS64Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_U32PtrInt
    (AA{<:UInt8}, AA{<:UInt8}) => ImPlot_PlotLine_U8PtrU8Ptr
    (AA{<:Int16}, AA{<:Int16}) => ImPlot_PlotLine_S16PtrS16Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_S8PtrInt
    (AA{<:UInt32}, AA{<:UInt32}) => ImPlot_PlotLine_U32PtrU32Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_doublePtrInt
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_S32PtrInt
    (AA{<:Int8}, AA{<:Int8}) => ImPlot_PlotLine_S8PtrS8Ptr
    # (AA{<:}, AA{<:}) => ImPlot_PlotLine_U64PtrInt       
]
for ((T1, T2), func) in line_functions
    @eval ImPlot_PlotLine(label_id, xs::$T1, ys::$T2, count, offset, stride) = $func(label_id, xs, ys, count, offset, stride)
end


line_functions_nox = [
    UInt16 => ImPlot_PlotLine_U16PtrInt
    Cfloat => ImPlot_PlotLine_FloatPtrInt
    Int64 => ImPlot_PlotLine_S64PtrInt
    UInt8 => ImPlot_PlotLine_U8PtrInt
    Int16 => ImPlot_PlotLine_S16PtrInt
    UInt32 => ImPlot_PlotLine_U32PtrInt
    Int8 => ImPlot_PlotLine_S8PtrInt
    Cdouble => ImPlot_PlotLine_doublePtrInt
    Int32 => ImPlot_PlotLine_S32PtrInt
    UInt64 => ImPlot_PlotLine_U64PtrInt
]
for (T1, func) in line_functions_nox
    @eval ImPlot_PlotLine(label_id, values::AbstractArray{<:$T1}, count, xscale=1.0, x0=0, offset=0, stride=$(sizeof(T1))) = $func(label_id, values, count, xscale, x0, offset, stride)
end

