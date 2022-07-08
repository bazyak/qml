import QtQuick 2.15

ListModel
{
    property string sortColumnName: ''
    property string order: 'asc'

    function swap(a,b)
    {
        if (a < b)
        {
            move(a, b, 1)
            move(b-1, a, 1)
        }
        else if (a > b)
        {
            move(b, a, 1)
            move (a-1, b, 1)
        }
    }

    function partition(begin, end, pivot)
    {
        const piv = get(pivot)[sortColumnName]
        swap(pivot, end-1)
        var store = begin
        var ix
        for (ix = begin; ix < end-1; ++ix)
        {
            if (order === 'asc')
            {
                if (get(ix)[sortColumnName] < piv)
                {
                    swap(store, ix)
                    ++store
                }
            }
            else if (order === 'desc')
            {
                if (get(ix)[sortColumnName] > piv)
                {
                    swap(store, ix)
                    ++store
                }
            }
        }
        swap(end-1, store)

        return store
    }

    function qSort(begin, end)
    {
        if (end-1 > begin)
        {
            var pivot = begin + Math.floor(Math.random() * (end - begin))

            pivot = partition(begin, end, pivot)

            qSort(begin, pivot)
            qSort(pivot+1, end)
        }
    }

    function quickSort()
    {
        qSort(0, count)
    }
}
