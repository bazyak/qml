function Database()
{
    this.db = LocalStorage.openDatabaseSync('storage', '1.0', '', 1024000)

    this.update = function(table, id, column, value)
    {
        const sql = 'UPDATE ' + table + ' SET ' + column + ' = "' + value + '" WHERE id = ' + id
        try
        {
            this.db.transaction((tx) => tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error updating table: ' + err)
            return false
        }
        return true
    }

    this.readContacts = function(model)
    {
        const sql = 'SELECT id, first_name, last_name, email, phone FROM contacts'
        var result = { }
        try
        {
            this.db.transaction((tx) => result = tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error selecting from table: ' + err)
        }
        for (var i = 0; i < result.rows.length; ++i)
        {
            model.appendRow({
                                id: result.rows[i].id,
                                first_name: result.rows[i].first_name,
                                last_name: result.rows[i].last_name,
                                email: result.rows[i].email,
                                phone: result.rows[i].phone
                            })
        }
    }

    this.readJobs = function(model)
    {
        const sql = 'SELECT id, title, description FROM jobs'
        var result = { }
        try
        {
            this.db.transaction((tx) => result = tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error selecting from table: ' + err)
        }
        for (var i = 0; i < result.rows.length; ++i)
        {
            model.appendRow({
                                id: result.rows[i].id,
                                title: result.rows[i].title,
                                description: result.rows[i].description
                            })
        }
    }

    this.addContact = function(firstName, lastName, email, phone)
    {
        const sql =
            'INSERT INTO contacts (first_name, last_name, email, phone)' +
            'VALUES("%1", "%2", "%3", "%4");'.arg(firstName).arg(lastName).arg(email).arg(phone)
        try
        {
            this.db.transaction((tx) => tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error inserting into table: ' + err)
        }
    }

    this.createContactsTable = function()
    {
        const sql =
            'CREATE TABLE IF NOT EXISTS contacts (' +
            'id INTEGER PRIMARY KEY,' +
            'first_name TEXT NOT NULL,' +
            'last_name TEXT NOT NULL,' +
            'email TEXT NOT NULL UNIQUE,' +
            'phone TEXT NOT NULL UNIQUE' +
            ');'
        try
        {
            this.db.transaction((tx) => tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error creating table: ' + err)
        }
    }

    this.addJob = function(title, description)
    {
        const sql =
            'INSERT INTO jobs (title, description)' +
            'VALUES("%1", "%2");'.arg(title).arg(description)
        try
        {
            this.db.transaction((tx) => tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error inserting into table: ' + err)
        }
    }

    this.createJobsTable = function()
    {
        const sql =
            'CREATE TABLE IF NOT EXISTS jobs (' +
            'id INTEGER PRIMARY KEY,' +
            'title TEXT NOT NULL UNIQUE,' +
            'description TEXT NOT NULL' +
            ');'
        try
        {
            this.db.transaction((tx) => tx.executeSql(sql))
        }
        catch (err)
        {
            console.log('Error creating table: ' + err)
        }
    }
}
