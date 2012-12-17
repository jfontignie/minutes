<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 17.12.12
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<body>
<table>
    <thead>
    <tr>
        <td>Subject</td>
        <td>Content</td>
        <td>Date</td>
    </tr>
    </thead>
    <tbody>

    <g:each in="${contentInstances}" var="contentInstance">
        <tr>
            <td>${contentInstance.title}</td>
            <td>${contentInstance.text}</td>
            <td><g:formatDate date="${contentInstance.meeting.dateEvent}"/></td>
        </tr>
    </g:each>
    </tbody>
</table>
</body>
</html>