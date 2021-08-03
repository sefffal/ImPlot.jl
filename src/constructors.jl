
ImPlot_ImPlotPoint() = ImPlot_ImPlotPoint(0,0)
ImPlot_ImPlotPoint(p::ImVec2) = ImPlot_ImPlotPoint(p.x, p.y)

ImPlot_ImPlotRange() = ImPlot_ImPlotRange(0,0)

ImPlot_ImPlotLimits() = ImPlot_ImPlotLimits(ImPlotRange(), ImPlotRange())
