function currentRate(source, dest)
{
    return dest.currentValue / source.currentValue
}

function updateAmount(dest, source, destAmount, sourceAmount)
{
    const rate = currentRate(source, dest)
    destAmount.text = sourceAmount.length
            ? Math.round((parseFloat(sourceAmount.text) * rate + Number.EPSILON) * 10000) / 10000
            : ''
}

function updateIndex(target, index)
{
    target.prevIndex = index
    target.currentIndex = index
}

function fetchData(source, dest, sourceCurr, destCurr)
{
    var xmlHttp = new XMLHttpRequest()
    var url = 'https://cdn.cur.su/api/cbr.json'
    xmlHttp.onreadystatechange = function()
    {
        if (xmlHttp.readyState == XMLHttpRequest.DONE && xmlHttp.status == 200)
        {
            parseRates(xmlHttp.responseText, source, dest, sourceCurr, destCurr)
        }
    }
    xmlHttp.open('GET', url, true)
    xmlHttp.send()
}

function parseRates(response, source, target, sourceCurr, destCurr)
{
    var json = JSON.parse(response)
    var i = 0
    for (const key in json.rates)
    {
        source.model.append({ key: key, value: json.rates[key] })
        target.model.append({ key: key, value: json.rates[key] })
        if (key == sourceCurr)
        {
            updateIndex(source, i)
        }
        if (key == destCurr)
        {
            updateIndex(target, i)
        }
        ++i
    }
}
