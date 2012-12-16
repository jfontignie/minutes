package minutes

/**
 * contains the meetings
 */
class Meeting {

    static searchable = true
    //static belongsTo = [session: Session]
    static hasMany = [users: User, contents: Content, children: Meeting]
    static mappedBy = [children: 'previousMeeting']


    Meeting previousMeeting
    Meeting rootMeeting

    String title
    Date dateEvent

    Date dateCreated
    Date lastUpdated

    String toString() {title + "[" + dateEvent + "]"}

    static constraints = {
        title()
        previousMeeting(nullable: true)
    }
}
