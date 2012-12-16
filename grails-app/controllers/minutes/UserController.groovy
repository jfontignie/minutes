package minutes

import grails.converters.JSON

class UserController {

    def scaffold = User

    def ajaxUserFinder() {
        log.info("Calling ajaxUserFinder with ${params.term}")
        def usersFound = User.withCriteria {
            ilike("initials" , "${params.term}%")
        }

//        def result = []
//        usersFound.each {
//            def map = []
//            map.put("id",it.getId())
//            map.put("label",it.getInitials())
//            map.put("value",it.getInitials())
//            result.add(map)
//        }

        def result = usersFound.collect {
            [id:it.getId(), label:it.getInitials(), value:it.getInitials()]
        }

        log.info("user found are: " + result)
        render (result as JSON)
    }
}
