<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>

<!-- historyTemplates.jsp -->
<html:xhtml/>

  <im:heading id="savedTemplates">
    <fmt:message key="history.savedtemplates.header"/>
  </im:heading>
  <im:body id="savedTemplates">
  
    <%-- Choose the queries to display --%>
    <c:choose>
      <c:when test="${empty PROFILE.savedTemplates}">
        <div class="altmessage">
          None
        </div>
      </c:when>
      <c:otherwise>
        <p>
          <fmt:message key="history.savedtemplates.help"/>
          <c:set var="helpUrl" value="${WEB_PROPERTIES['project.helpLocation']}/manual/manualQuickStartTemplates.html"/>
          [<html:link href="${helpUrl}"><fmt:message key="begin.link.help"/></html:link>]
        </p>
        <html:form action="/modifyTemplate">
        <table class="results history" cellspacing="0">
          <tr>
            <th>
              &nbsp;
            </th>
            <th align="left" nowrap>
              <fmt:message key="history.namecolumnheader"/>
            </th>
          <%--  <th align="center" nowrap>
              <fmt:message key="history.datecreatedcolumnheader"/>
            </th> --%>
            <th align="left" nowrap>
              <fmt:message key="history.descriptionheader"/>
            </th>
            <th align="center" nowrap>
              <fmt:message key="history.actionscolumnheader"/>
            </th>
          </tr>    
          <c:forEach items="${PROFILE.savedTemplates}" var="savedTemplate">
            <tr>
              <td>
                <html:multibox property="selected">
                  <c:out value="${savedTemplate.key}"/>
                </html:multibox>
              </td>
              
              <c:choose>
                <c:when test="${!savedTemplate.value.valid}">
                  <td align="left" nowrap">
                    <html:link action="/templateProblems?name=${savedTemplate.key}&amp;type=user" styleClass="brokenTmplLink">
                    <strike>${savedTemplate.value.name}</strike>
                    </html:link>
                  </td>
                </c:when>
                <c:otherwise>
                  <td nowrap>
                    <fmt:message var="linkTitle" key="templateList.run">
                      <fmt:param value="${savedTemplate.value.name}"/>
                    </fmt:message>
                    <html:link action="/template?name=${savedTemplate.value.name}&amp;type=user" 
                           title="${linkTitle}">
                      ${savedTemplate.value.name}
                    </html:link>
                  </td>
                </c:otherwise>
              </c:choose>
              
                
              </td>
              <%--
              <td align="center" nowrap>
                <c:choose>
                  <c:when test="${savedQuery.value.dateCreated != null}">
                    <fmt:formatDate value="${savedQuery.value.dateCreated}" type="both" pattern="dd/M/yy K:mm a"/>
                  </c:when>
                  <c:otherwise>
                    n/a
                  </c:otherwise>
                </c:choose>
              </td>
              --%>
              <td nowrap>
                <c:choose>
                  <c:when test="${fn:length(savedTemplate.value.description) > 60}">
                    ${fn:substring(savedTemplate.value.description, 0, 60)}...
                  </c:when>
                  <c:otherwise>
                    ${savedTemplate.value.description}
                  </c:otherwise>
                </c:choose>
              </td>
              <td align="center" nowrap>
                <html:link action="/editTemplate?name=${savedTemplate.value.name}">
                  Edit
                </html:link>
              </td>
            </tr>
          </c:forEach>
        </table>
        <br/>
        <html:submit property="delete">
          <fmt:message key="history.delete"/>
        </html:submit>
        </html:form>
        <br/>
      </c:otherwise>
    </c:choose>
    
  </im:body>
  
<c:if test="${IS_SUPERUSER}">
  <span class="smallnote">
    <c:if test="${!empty PROFILE.savedTemplates}">
      <html:link action="/exportTemplates?type=user" titleKey="begin.exportTemplatesDesc">
        <fmt:message key="begin.exportTemplates"/>
      </html:link><br/>
    </c:if>
    <html:link action="/import" titleKey="begin.importTemplatesDesc">
      <fmt:message key="begin.importTemplates"/>
    </html:link>
  </span>
</c:if>

<!-- /historyTemplates.jsp -->
