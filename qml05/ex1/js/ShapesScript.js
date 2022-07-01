const kStepDivider = 5

function getShape(type, size)
{
    const minSide = Math.min(size.width, size.height)
    const xCenter = size.width / 2
    const yCenter = size.height / 2
    const step = minSide / Math.max(kStepDivider, 4)

    return eval(type + '(xCenter, yCenter, step)')
}

function star(xCenter, yCenter, step)
{
    var points = []
    points.push(Qt.point(xCenter + 0.0 * step, yCenter - 1.5 * step))
    points.push(Qt.point(xCenter - 1.0 * step, yCenter + 1.5 * step))
    points.push(Qt.point(xCenter + 1.5 * step, yCenter - 0.5 * step))
    points.push(Qt.point(xCenter - 1.5 * step, yCenter - 0.5 * step))
    points.push(Qt.point(xCenter + 1.0 * step, yCenter + 1.5 * step))

    return points
}

function circle(xCenter, yCenter, step)
{
    var xCircle = (deg, r) => Math.round(Math.cos(Math.PI / 180 * deg) * r * 100) / 100;
    var yCircle = (deg, r) => Math.round(Math.sin(Math.PI / 180 * deg) * r * 100) / 100;

    const radius = step * 1.5
    var points = []
    for (var i = 0; i < 360; ++i)
    {
        points.push(Qt.point(xCircle(i, radius) + xCenter, yCircle(i, radius) + yCenter))
    }
    return points
}

function house(xCenter, yCenter, step)
{
    var points = []
    points.push(Qt.point(xCenter + 1.2 * step, yCenter - 0.5 * step))
    points.push(Qt.point(xCenter + 0.0 * step, yCenter - 1.5 * step))
    points.push(Qt.point(xCenter - 1.2 * step, yCenter - 0.5 * step))
    points.push(Qt.point(xCenter + 1.2 * step, yCenter - 0.5 * step))
    points.push(Qt.point(xCenter + 1.2 * step, yCenter + 1.5 * step))
    points.push(Qt.point(xCenter - 1.2 * step, yCenter + 1.5 * step))
    points.push(Qt.point(xCenter - 1.2 * step, yCenter - 0.5 * step))

    return points
}

function sandglass(xCenter, yCenter, step)
{
    var points = []
    points.push(Qt.point(xCenter + step, yCenter - 1.5 * step))
    points.push(Qt.point(xCenter - step, yCenter - 1.5 * step))
    points.push(Qt.point(xCenter + step, yCenter + 1.5 * step))
    points.push(Qt.point(xCenter - step, yCenter + 1.5 * step))
    points.push(Qt.point(xCenter + step, yCenter - 1.5 * step))

    return points
}
