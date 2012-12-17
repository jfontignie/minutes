<%@ page import="minutes.Meeting" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'meeting.label', default: 'Meeting')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>

</head>

<body>
<a href="#show-meeting" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>
<r:script disposition="head">

</r:script>



<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-meeting" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list meeting">

        <g:if test="${meetingInstance?.previousMeeting}">
            <li class="fieldcontain">
                <span id="previousMeeting-label" class="property-label"><g:message code="meeting.previousMeeting.label"
                                                                                   default="Previous Meeting"/></span>

                <span class="property-value" aria-labelledby="previousMeeting-label"><g:link controller="meeting"
                                                                                             action="show"
                                                                                             id="${meetingInstance?.previousMeeting?.id}">${meetingInstance?.previousMeeting?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${meetingInstance?.title}">
            <li class="fieldcontain">
                <span id="title-label" class="property-label"><g:message code="meeting.title.label"
                                                                         default="Title"/></span>

                <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${meetingInstance}"
                                                                                         field="title"/></span>

            </li>
        </g:if>


        <g:if test="${meetingInstance?.contents}">
            <li class="fieldcontain">
                <span id="contents-label" class="property-label"><g:message code="meeting.contents.label"
                                                                            default="Contents"/></span>
                <table>
                    <tbody>
                    <g:each in="${meetingInstance.contents}" var="c">
                        <tr>
                         <td class="property-value" aria-labelledby="contents-label"><g:link controller="crudContent"
                                                                                             action="show"
                                                                                             id="${c.id}">${c.title?.encodeAsHTML()}</g:link></td>
                        <td class="content">
                            ${c.text.encodeAsHTML()}
                        </td>
                    </g:each>
                    </tbody>
                </table>

            </li>
        </g:if>


        <g:if test="${meetingInstance?.users}">
            <li class="fieldcontain">
                <span id="users-label" class="property-label"><g:message code="meeting.users.label"
                                                                         default="Users"/></span>

                <g:each in="${meetingInstance.users}" var="u">
                    <span class="property-value" aria-labelledby="users-label"><g:link controller="user" action="show"
                                                                                       id="${u.id}">${u?.encodeAsHTML()}</g:link></span>
                </g:each>

            </li>
        </g:if>

        <g:if test="${meetingInstance?.dateCreated}">
            <li class="fieldcontain">
                <span id="dateCreated-label" class="property-label"><g:message code="meeting.dateCreated.label"
                                                                               default="Date Created"/></span>

                <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                        date="${meetingInstance?.dateCreated}"/></span>

            </li>
        </g:if>

        <g:if test="${meetingInstance?.dateEvent}">
            <li class="fieldcontain">
                <span id="dateEvent-label" class="property-label"><g:message code="meeting.dateEvent.label"
                                                                             default="Date Event"/></span>

                <span class="property-value" aria-labelledby="dateEvent-label"><g:formatDate
                        date="${meetingInstance?.dateEvent}"/></span>

            </li>
        </g:if>

        <g:if test="${meetingInstance?.lastUpdated}">
            <li class="fieldcontain">
                <span id="lastUpdated-label" class="property-label"><g:message code="meeting.lastUpdated.label"
                                                                               default="Last Updated"/></span>

                <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                        date="${meetingInstance?.lastUpdated}"/></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${meetingInstance?.id}"/>
            <g:link class="edit" action="edit" id="${meetingInstance?.id}"><g:message code="default.button.edit.label"
                                                                                      default="Edit"/></g:link>
            <g:link class="edit" action="next" id="${meetingInstance?.id}"><g:message code="default.button.next.label" default="Create next meeting"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
