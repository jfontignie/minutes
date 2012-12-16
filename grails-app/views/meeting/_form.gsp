<%@ page import="minutes.Content; minutes.Meeting" %>



<r:script disposition='head'>

    var countSubjects = ${contents?.size ?: 0};
    var countUsers = ${meetingInstance?.users?.size ?: 0};

    function addSubject(tableID) {

        var table = document.getElementById(tableID);

        var rowCount = table.rows.length;

        var row = table.insertRow(rowCount);


        var cell1 = row.insertCell(0);
        var element1 = document.createElement("input");
        element1.type = "text";
        element1.name = "meeting.subject" + countSubjects;
        cell1.appendChild(element1);


        var cell2 = row.insertCell(1);
        var element2 = document.createElement("textarea");
        element2.name = "meeting.content" + countSubjects;
        element2.row = 5
        element2.col=40
        cell2.appendChild(element2);

        countSubjects++;
    }

    function addUser(tableID) {
        var table = document.getElementById(tableID);

        var rowCount = table.rows.length;

        var row = table.insertRow(rowCount);

        var cell1 = row.insertCell(0);
        var element1 = document.createElement("input");
        element1.type = "text";
        element1.id = "meeting.user" + countUsers;
        element1.name = element1.id;

        cell1.appendChild(element1);
        $('[id^="meeting.user"]').autocomplete({
            source: '<g:createLink controller='User' action='ajaxUserFinder'/>'
        });

        var cell2 = row.insertCell(1);
        var element2 = document.createElement("a");
        element2.title = "remove";
        element2.innerHTML = element2.title;
        element2.onclick = function(){removeRow(tableID,row)};
        cell2.appendChild(element2);

        countUsers++;

    }

    function removeRow(tableID,row) {

       var table = document.getElementById(tableID);

       var rowCount = table.rows.length;

       for(var i=0; i< rowCount; i++) {
            if (table.rows[i] == row) {
                table.deleteRow(i);
                break
            }
       }
    }

    function openPreviousMeeting() {
        $("#dialog" ).dialog("open");
    }

    $(document).ready(function(){
        $('[id^="meeting.user"]').autocomplete({
            source: '<g:createLink controller='User' action='ajaxUserFinder'/>'
        });
    });

    $(function(){
        $("#dialog" ).dialog({ autoOpen: false });
    });

</r:script>

<g:hiddenField name="meeting.parent" value="${meetingInstance?.previousMeeting?.id}"/>
<g:hiddenField name="meeting.root" value="${meetingInstance?.rootMeeting?.id}"/>

<div>
    <h3>Title</h3><g:textField name="meeting.title" value="${meetingInstance?.title}"/>
    <g:if test="${meetingInstance?.previousMeeting}">
        <h4>
            <a onclick='openPreviousMeeting()'>${meetingInstance.previousMeeting}</a>
        </h4>
    </g:if>
</div>
<br/>

<g:if test="${meetingInstance.previousMeeting}">
    <div id="dialog" title="Previous meeting">
        <g:render template="previous"/>

    </div>
</g:if>

<div>
    <h3>Date</h3><g:datePicker name="meeting.date" precision="day"
                               value="${meetingInstance?.dateEvent}"/>
</div>

<div class="users">
    <h3>Users</h3>
    <a onclick="addUser('users')">Add user</a>
    <table id="users">
        <tbody></tbody>
        <g:each in="${meetingInstance?.users}" status="i" var="userInstance">
            <tr id="row${i}">

                <td><g:textField name="meeting.user${i}" id="meeting.user${i}" value="${userInstance.initials}"/></td>
                <td><a onclick='removeRow("users", this.parentNode.parentNode)'>remove</a></td>
            </tr>
        </g:each>
    </table>
</div>

<div class="subjects">
    <h3>Subjects</h3>
    <a onclick="addSubject('subjects')">Add subject</a>

    <table id="subjects">
        <thead><tr>
            <td>Subject</td>
            <td>Content</td>
        </tr></thead>
        <tbody>
        <g:each in="${contents}" status="i" var="contentInstance">
            <tr>

                <td><g:textField name="meeting.subject${i}" value="${contentInstance.getTitle()}"/></td>
                <td><g:textArea name="meeting.content${i}" rows="5"
                                cols="40">${contentInstance.getText()}</g:textArea></td>
            </tr>
        </g:each>

        </tbody>

    </table>
</div>
