String.prototype.replaceAll = function(search, replacement)
{
    var target = this
    return target.split(search).join(replacement)
}

const baseUrl = 'https://www.breakingbadapi.com/api/'

function fetchData(endpoint, queryName, result)
{
    var xmlHttp = new XMLHttpRequest()
    const url = baseUrl + endpoint
    xmlHttp.onreadystatechange = function()
    {
        if (xmlHttp.readyState == XMLHttpRequest.DONE && xmlHttp.status == 200)
        {
            parseData(xmlHttp.responseText, queryName, result)
        }
    }
    xmlHttp.open('GET', url, true)
    xmlHttp.send()
}

function parseData(response, queryName, result)
{
    var json = JSON.parse(response)
    eval(queryName + '(json, result)')
}

function episodes(json, model)
{
    model.clear()
    for (const ep of json)
    {
        const chs = []
        for (const ch of ep.characters)
        {
            chs.push({ ch })
        }
        model.append({
            id: ep.episode_id,
            title: ep.title,
            season: 'Season ' + ep.season,
            airDate: ep.air_date,
            episode: ep.episode,
            characters: chs })
    }
}

function deathsCount(json, count)
{
    eval(count + ' = json[0].deathCount')
}

function quotes(json, object)
{
    object.text = ''
    var items = []
    for (const quote of json)
    {
        items.push('- ' + quote.quote)
    }
    object.text = items.join('\n')
}

function character(json, object)
{
    object.photo = ''
    object.nickname = ''
    object.birthday = ''
    object.status = ''
    object.occupation = ''
    if (json.length)
    {
        var items = []
        for (const occ of json[0].occupation)
        {
            items.push(occ)
        }
        object.photo = json[0].img
        object.nickname = json[0].nickname
        object.birthday = json[0].birthday
        object.status = json[0].status
        object.occupation = items.join(', ')
    }
}

function death(json, object)
{
    object.text = ''
    if (json.length)
    {
        object.text += Constants.kInfoDialogCausePrefixText + json[0].cause + '\n'
        object.text += Constants.kInfoDialogResponsiblePrefixText + json[0].responsible + '\n'
        object.text += Constants.kInfoDialogLastWordsPrefixText + json[0].last_words + '\n'
        object.text += Constants.kInfoDialogEpisodePrefixText + json[0].season + '.' + json[0].episode
    }
}
