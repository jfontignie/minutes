<%@ page import="minutes.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'position', 'error')} required">
	<label for="position">
		<g:message code="event.position.label" default="Position" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="position" min="0" required="" value="${eventInstance.position}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="event.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${eventInstance?.date}"  />
</div>

