<%@ page import="minutes.Meeting" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'meeting.label', default: 'Meeting')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-meeting" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-meeting" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="title" title="${message(code: 'meeting.title.label', default: 'Title')}"/>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'meeting.dateCreated.label', default: 'Date Created')}"/>

            <g:sortableColumn property="dateEvent"
                              title="${message(code: 'meeting.dateEvent.label', default: 'Date Event')}"/>

            <g:sortableColumn property="lastUpdated"
                              title="${message(code: 'meeting.lastUpdated.label', default: 'Last Updated')}"/>

            <th><g:message code="meeting.previousMeeting.label" default="previousMeeting"/></th>


        </tr>
        </thead>
        <tbody>
        <g:each in="${meetingInstanceList}" status="i" var="meetingInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show" id="${meetingInstance.id}">${fieldValue(bean: meetingInstance, field: "title")}</g:link></td>


                <td><g:formatDate date="${meetingInstance.dateCreated}"/></td>

                <td><g:formatDate date="${meetingInstance.dateEvent}"/></td>

                <td><g:formatDate date="${meetingInstance.lastUpdated}"/></td>

                <td><g:link action="show"
                            id="${meetingInstance.id}">${fieldValue(bean: meetingInstance, field: "previousMeeting")}</g:link></td>


            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${meetingInstanceTotal}"/>
    </div>
</div>
</body>
</html>
