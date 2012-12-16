package minutes

class Subject {

    static belongsTo = [session:Session]
    static hasMany = [contents: Content]

    String subject
    SubjectState state

    String toString() {
        return subject
    }

    static constraints = {
        subject(blank: false)
    }
}
