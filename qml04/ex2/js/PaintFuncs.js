function scatterPaint()
{
    scatterChart.removePoints(0, scatterChart.count)
    if (!lsmService.scatterVectorX.length) return

    for (var x in lsmService.scatterVectorX)
    {
        if (x < lsmService.scatterVectorY.length && isFinite(lsmService.scatterVectorY[x]))
        {
            scatterChart.append(lsmService.scatterVectorX[x], lsmService.scatterVectorY[x])
        }
    }
    const minY = Math.floor(Math.min.apply(Math, lsmService.scatterVectorY))
    const maxY = Math.ceil(Math.max.apply(Math, lsmService.scatterVectorY))
    const minX = Math.floor(Math.min.apply(Math, lsmService.scatterVectorX))
    const maxX = Math.ceil(Math.max.apply(Math, lsmService.scatterVectorX))
    axisY.min = minY - 1
    axisY.max = maxY + 1
    axisX.min = minX - 1
    axisX.max = maxX + 1
}

function linePaint()
{
    lineChart.removePoints(0, lineChart.count)
    if (lsmService.lineVectorX.length < 2) return

    for (var x in lsmService.lineVectorX)
    {
        if (x < lsmService.lineVectorY.length && isFinite(lsmService.lineVectorY[x]))
        {
            lineChart.append(lsmService.lineVectorX[x], lsmService.lineVectorY[x])
        }
    }
    const minY = Math.min(lsmService.lineVectorY[0], axisY.min)
    const maxY = Math.max(lsmService.lineVectorY[lsmService.lineVectorY.length-1], axisY.max)
    axisY.min = Math.floor(minY)
    axisY.max = Math.ceil(maxY)
    axisY.tickCount = lsmService.lineVectorY.length
    axisY.tickType = ValueAxis.TicksFixed

    axisX.min = lsmService.lineVectorX[0]
    axisX.max = lsmService.lineVectorX[lsmService.lineVectorX.length-1]
    axisX.tickCount = lsmService.lineVectorX.length
    axisX.tickType = ValueAxis.TicksFixed
}

function rePaint()
{
    var vectorX = []
    var vectorY = []
    for(var i = 0; i < kModelCount; ++i)
    {
        const x = parseFloat(repeaterX.itemAt(i).text.replace(',', '.'))
        const y = parseFloat(repeaterY.itemAt(i).text.replace(',', '.'))
        if (!Number.isNaN(x) && !Number.isNaN(y))
        {
            vectorX.push(x)
            vectorY.push(y)
        }
    }
    lsmService.scatterVectorX = vectorX
    lsmService.scatterVectorY = vectorY
    scatterPaint()
    lsmService.calcLsm()
}
