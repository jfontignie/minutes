package minutes

class UserInteraction {

    static belongsTo = [user:User]

    User user
    InteractionType interactionType
    int position

    static constraints = {
        user(nullable:false)
        interactionType(nullable: false)
        position(min:0)
    }
}
