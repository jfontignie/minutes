package minutes

class User {

    static searchable = true
    String initials

    String email

    String toString() {
        return initials
    }

    static constraints = {
        initials(unique: true, blank: false)
        email(email: true, blank: false)
    }
}
