<g:if test="${meetingInstance.previousMeeting}">
    <h3>${meetingInstance.previousMeeting}</h3>
    <g:set var="previous" value="${meetingInstance.previousMeeting}"/>
    <table>
        <thead>
        <tr>
            <td>Subject</td>
            <td>Content</td>
        </tr>
        </thead>
        <tbody>
        <g:render template="showContent" collection="${previous.contents}"/>
        </tbody>
    </table>
</g:if>