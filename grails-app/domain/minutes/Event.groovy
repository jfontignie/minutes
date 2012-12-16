package minutes

class Event {

    Date date
    int position

    static constraints = {
        position(min: 0)
    }
}
