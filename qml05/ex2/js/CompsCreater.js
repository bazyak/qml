function CustomObject(parent, fileName)
{
    this.component = Qt.createComponent(fileName);
    var obj = new FinishCreation(parent, this.component)

    if (this.component.status == Component.Ready)
    {
        obj.justDoIt()
    }
    else
    {
        this.component.statusChanged.connect(obj.justDoIt)
    }

    this.getObject = function() { return obj.getSprite() }
}

function FinishCreation(parent, comp)
{
    this.parent = parent
    this.component = comp
    this.sprite = undefined

    this.justDoIt = function()
    {
        if (this.component.status == Component.Ready)
        {
            this.sprite = this.component.createObject(this.parent);
            if (this.sprite == null)
            {
                print("Error creating object");
            }
        }
        else if (this.component.status == Component.Error)
        {
            print("Error loading component:", this.component.errorString());
        }
    }

    this.getSprite = function() { return this.sprite }
}
