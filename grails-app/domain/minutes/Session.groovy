package minutes

class Session {

    static searchable = true
    String title

    Date dateCreated
    Date lastUpdated

    String toString() {title}

    static hasMany = [users:User,meetings:Meeting]

    static constraints = {
        title(blank:false)

    }
}
