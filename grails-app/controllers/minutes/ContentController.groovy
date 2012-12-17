package minutes

import grails.converters.JSON

class ContentController {

    def showHistory() {
        def contentInstance = Content.get(params.id)
        if (!contentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }
        //let's get all the contents
        def c = Content.createCriteria()
        def rootMeeting = contentInstance.getMeeting().getRootMeeting() ?: contentInstance.getMeeting()

        def list = c.list {
            meeting {
                eq("id", rootMeeting.getId())
                order("dateEvent", "desc")

            }
        }

        [contentInstances: list]

    }
}
