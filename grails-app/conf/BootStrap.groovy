import minutes.*

class BootStrap {

    def init = { servletContext ->

        if (!User.count) {
            (1..10).each {new User(initials: "${it}${it}${it}", email: it + "@b.com").save()}


            log.info(User.count + " users have been created")


            new Session(title: "pdt").save()

        }


    }
    def destroy = {
    }
}
