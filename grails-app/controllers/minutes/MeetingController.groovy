package minutes

import grails.converters.JSON

class MeetingController {

    def index() {
        redirect(action: "list", params: params)
    }

    def create() {
        [meetingInstance: new Meeting()]
    }

    def next() {
        log.info("params" + params)
        def meeting = new Meeting();
        def parent = Meeting.get(params.id)
        meeting.setPreviousMeeting(parent)

        meeting.setTitle(parent.getTitle())
        def contents = parent.getContents().collect {
            log.info("adding child from previous meeting: ${it}")
            new Content(title: it.title)
        }
        meeting.setRootMeeting(parent.getRootMeeting() ?: parent)


        def map = [meetingInstance: meeting, contents: contents]
        render(view: "create", model: map)
    }

    def edit() {
        def meetingInstance = Meeting.get(params.id)
        if (!meetingInstance) {
            meetingInstance = new Meeting()
        }

        [meetingInstance: meetingInstance, contents: meetingInstance.getContents()]
    }


    def update() {
        def meetingInstance = Meeting.get(params.id)
        if (!meetingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (meetingInstance.version > version) {
                meetingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'meeting.label', default: 'Event')] as Object[],
                        "Another user has updated this Meeting while you were editing")
                render(view: "edit", model: [meetingInstance: meetingInstance])
                return
            }
        }

        saveMeeting(params)

    }

    def saveMeeting(def params) {
        log.info("ici2")
        log.info(params)

        def m = params.get("meeting")
        log.info(m)

        String title = m.title
        log.info("title is: " + title)

        def meeting = Meeting.get(params.id) ?: new Meeting()
        meeting.setTitle(title ?: "<unknown>")
        meeting.setDateEvent(m.date)
        meeting.setPreviousMeeting(Meeting.get(m.parent))
        meeting.setRootMeeting(Meeting.get(m.root))

        if (!meeting.save()) {
            log.error(meeting.errors);
            render(view: "edit", model: [meetingInstance: meeting])
            return
        }


        m.findAll {w -> w.getKey().startsWith("user")
        }.each {
            def user = User.findByInitials(it.getValue())
            if (!user) {
                meeting.delete()
                render(view: "edit", model: [meetingInstance: meeting])
                return
            }
            meeting.addToUsers(user)
        }



        if (!meeting.save()) {
            log.error(meeting.errors);
        }
        log.info("meeting has been saved: " + meeting)

        m.findAll {w -> w.getKey().startsWith("subject")
        }.each {
            String key = it.getKey()
            String subject = it.getValue()

            String substring = key.substring(7)
            String text = m["content${substring}"]
            def content = Content.findByTitleAndMeeting(subject, meeting) ?: new Content()

            content.setTitle(subject ?: "<empty>")
            content.setText(text ?: "<empty>")
            content.setMeeting(meeting)
            if (!content.save())
                log.error(content.errors)
            if (!content.getText() && !content.getTitle())
                content.delete()
        }

        redirect(controller: "Meeting", action: "show", params: [id: meeting.getId()])
    }

    def save() {
        saveMeeting(params)

    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [meetingInstanceList: Meeting.list(params), meetingInstanceTotal: Meeting.count()]
    }

    def show() {
        def meetingInstance = Meeting.get(params.id)
        if (!meetingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
            redirect(action: "list")
            return
        }

        [meetingInstance: meetingInstance]
    }

    def graph() {

//        def meetingInstance = Meeting.get(params.id)
//        if (!meetingInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
//            redirect(action: "list")
//            return
//        }
//        [meetingInstance: meetingInstance]
    }

    def lineage() {
        def result
        if (!params.id) {
            result = [id: -1, name: ".", children: Meeting.findAllByRootMeetingIsNull().collect {lineageNode(it)}]

        } else {
            def meetingInstance = Meeting.get(params.id)
            if (!meetingInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'meeting.label', default: 'Meeting'), params.id])
                redirect(action: "list")
                return
            }
            result = [lineageNode(meetingInstance)]
        }

        render result as JSON


    }

    private def lineageNode(Meeting meetingInstance) {

        def root = meetingInstance.getRootMeeting() ?: meetingInstance
        def result = recursiveNode(root)
        return result

    }

    private def recursiveNode(Meeting node) {
        [id: node.getId(),
                name: node.getTitle(),
                children: node.getChildren().collect {recursiveNode(it)}
        ]
    }
}
