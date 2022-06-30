function getShape(type, size)
{
    return eval(type + '(size)')
}

function star(size)
{
    const width = size.width
    const height = size.height
    const xStep = width / 6
    const yStep = height / 5

    var points = []
    points.push(Qt.point(3 * xStep, yStep))
    points.push(Qt.point(2 * xStep, 4 * yStep))
    points.push(Qt.point(4.5 * xStep, 2 * yStep))
    points.push(Qt.point(1.5 * xStep, 2 * yStep))
    points.push(Qt.point(4 * xStep, 4 * yStep))

    return points
}

function circle(size)
{
    const width = size.width
    const height = size.height
    const xStep = width / 6
    const yStep = height / 5
    var rects = []

    rects.push(Qt.point(300, 20))
    rects.push(Qt.rect(500, 20, 500, 220))
    rects.push(Qt.rect(500, 420, 300, 420))
    rects.push(Qt.rect(100, 420, 100, 220))
    rects.push(Qt.rect(100, 20, 300, 20))



    ctx.arcTo(500, 20, 500, 220, 200);
    ctx.arcTo(500, 420, 300, 420, 200);
    ctx.arcTo(100, 420, 100, 220, 200);
    ctx.arcTo(100, 20, 300, 20, 200);

    points.push(Qt.rect(3 * xStep, yStep))

}

function house(size)
{

}

function sandglass(size)
{

}
