<r:script disposition="head">
    function showHistory(id) {
        var url = "../../content/showHistory/" + id;
        document.getElementById("iframeHistory").src = url;
        $("#history").dialog("open");
    }

</r:script>

<tr>
    <td><a onclick="showHistory(${it.id})">${it.title}</a></td>
    <td>${it.text}</td>
</tr>