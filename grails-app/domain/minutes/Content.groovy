package minutes

class Content {

    static searchable = true
    static belongsTo = [meeting: Meeting]

    String title
    String text

    Date dateCreated
    Date lastUpdated

    static constraints = {
        title()
        text(maxSize: 1024 * 1024)
        meeting()
    }


}
