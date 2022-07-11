const baseUrl = 'https://api.weatherbit.io/v2.0/current?key=' + Constants.kApiKey + '&'

function fetchData(params, result)
{
    var xmlHttp = new XMLHttpRequest()
    const url = baseUrl + params
    xmlHttp.onreadystatechange = function()
    {
        if (xmlHttp.readyState == XMLHttpRequest.DONE && xmlHttp.status == 200)
        {
            parseData(xmlHttp.responseText, result)
        }
    }
    xmlHttp.open('GET', url, true)
    xmlHttp.send()
}

function parseData(response, result)
{
    var json = JSON.parse(response)
    result.windDir = ''
    result.windSpeed = ''
    result.temp = ''
    result.appTemp = ''
    result.icon = ''
    result.description = ''
    result.hum = ''

    if (json.data.length)
    {
        result.windDir = json.data[0].wind_cdir_full
        result.windSpeed = json.data[0].wind_spd
        result.temp = json.data[0].temp
        result.appTemp = json.data[0].app_temp
        result.icon = json.data[0].weather.icon
        result.description = json.data[0].weather.description
        result.hum = json.data[0].rh
    }
    if (parseInt(result.temp) > 0)
        result.temp = '+' + result.temp
    if (parseInt(result.appTemp) > 0)
        result.appTemp = '+' + result.appTemp
}
