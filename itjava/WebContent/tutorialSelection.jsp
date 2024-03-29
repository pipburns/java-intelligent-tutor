<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, itjava.model.*, org.eclipse.jdt.core.dom.Message;"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Select tutorials here..</title>
<link type="text/css" rel="stylesheet" href="css/tutorialSelection.css"/>
<link href="css/maincss.css" rel="stylesheet" type="text/css" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript" src="js/ratingsys.js"></script> 
<script type="text/javascript" language="javascript" src="js/main.js"></script> 
<style type="text/css">
<style>
.navmain a {
	font-family: segoe ui, verdana;
	font-size: 12px;
	font-weight: bold;
	color: #FFF;
	text-decoration: none;
}
.asdf {
	color: #000;
	font-weight: bold;
}
.basic {
	font-family: segoe ui, verdana;
	font-size: 12px;
	color: #333;
	text-align: center;
}
.basicbutton {
	font-family: segoe ui, verdana;
	font-size: 12px;
	color: #333;
	text-align: center;
}
.titles {
	font-family: segoe ui, verdana;
	font-weight: bold;
	font-size: 16px;
	color: #3E4854;
}
#form1 table tr td p {
	color: #900;
}
.basic1 {	font-family: segoe ui, verdana;
	font-size: 12px;
	color: #333;
	text-align: left;
}
#form2 table tr td table tr .basic {
	text-align: right;
}
#divProgress {
	width:100%;
	height:200px;
	text-align:center;
	font-family: segoe ui, verdana;
	display: none;
}
#query {
	width:450px;
	border-color:#333;
	border-style:inset;
	border-width:1px;
	margin: 5px 0 0 0;
	font-family: segoe ui, verdana;
	font-size:12px;
}
#btnSearch {
	background-color:#EEE;
	border:solid;
	border-style:outset;
	border-width:1px;
	border-color:#CCC;
	margin: 3px 0 0 0;
	font-family: segoe ui, verdana;
	font-size:12px;
}
#spanChange:hover {
	text-decoration:underline;
	background-color: orange;
	cursor: pointer;
}
#cancelChange {
	color: #f26818;
	background-color:pink;
	cursor: pointer;
	border:solid;
	border-style:outset;
	border-width:1px;
	border-color:#f26818;
}
#cancelChange:hover {
	color: red;
	border-color:red;
}

#divNewWordNote {
	font-size: .8em;
}

.tdSmall {
	width: 1em;
}

#divMessages {
	font-size: 0.9em;
	width: 60%;
	margin-left: 10px;
}

#toggleMessage:hover {
	text-decoration:underline;
	background-color: orange;
	cursor: pointer;
}

#compilerMessages {
	border:solid;
	border-width:1px;
	border-color:#CCC;
	display:none;
	font-family:Consolas;
}

pre {
	font-family:Consolas;
}
#divEditButton {
	display: none;
}
</style>
<script src="http://code.jquery.com/jquery-1.4.4.js"></script>
<script type="text/javascript">
var submitType;
$(function () {
    toggleHints();
    
    $('#divWordInfo input:checkbox').click(toggleHints);
	
    $('#divApproveSample input:radio').click(function () {
        var step2 = $('#divWordInfo');  
        var step3 = $('#divRating');
		var step4 = $('#divHint');
        if (this.value == 'Quiz')  {
            step2.show('slow');  
        	step3.show('slow');
			$('#divEditButton').hide();
			$('#divSubmit').show();
        }
		else if(this.value == 'Edit') {
			$('#divEditButton').show();
			step2.hide('slow');  
            step3.hide('slow'); 
			step4.hide('slow');
			$('#divSubmit').hide();
		}
        else {  
            step2.hide('slow');  
            step3.hide('slow'); 
			step4.hide('slow');
			$('#divEditButton').hide();
			$('#divSubmit').show();
        }  
    });
    
	$('#spanChange').click(function () {
		$('#divNewWord').toggle('slow');
	});
	
	$('#cancelChange').click(function () {
		$('#divNewWord').toggle('slow');
	});
	
	$('#toggleMessage').click(function () {
		$('#compilerMessages').toggle('fast');
	});
	
    function toggleHints(){
    	$('#divHint').hide();
    	$('#divHint div').hide();
    	var allVals = [];
    	$('#divWordInfo input:checkbox:checked').each(function () {
    		allVals.push(this.value);
    	}); 
		if (allVals.length > 0) {
			$('#divHint').show();
			$('#divHint .step').show();
		}
		for (var i =0 ; i < allVals.length; i++ ) {
			var divHintId = "divHint" + allVals[i];
			document.getElementById(divHintId).style.display = "block";
		} 
    }
});   

function setSubmit(str) {
	submitType = str;
}

function isReady(eventSource) {
	if (submitType == "newWord") {
		return true;
	}
	else if (document.tutorialSelectionForm.radioApproval[1].checked || 
			document.tutorialSelectionForm.radioApproval[2].checked  || 
			document.tutorialSelectionForm.radioApproval[3].checked) {
		return true;
	}
	else if (document.tutorialSelectionForm.radioApproval[0].checked) {
		var wordInfoFlag = false;
		var difficultyFlag = false;
		var numOfWords = 1;
		if (document.tutorialSelectionForm.cbxWordInfo == null) {
			alert("Please add words before creating quiz. Otherwise, you can treat the snippet as example or discard it.");
			return false;
		}
		else if(document.tutorialSelectionForm.cbxWordInfo.length == null && document.tutorialSelectionForm.cbxWordInfo.checked == true) {
			wordInfoFlag = true;
		}
		else if (document.tutorialSelectionForm.cbxWordInfo.length >= 0) {
			for (var i = 0; i < document.tutorialSelectionForm.cbxWordInfo.length; i++) {
				if (document.tutorialSelectionForm.cbxWordInfo[i].checked) {
					wordInfoFlag = true;
					break;
				}
			}
		}
		
		for (i =0; i < 5; i++) {
			if (document.tutorialSelectionForm.difficultyLevel[i].checked) {
				difficultyFlag = true;
				break;
			}
		}
		if (difficultyFlag && wordInfoFlag) {
			return true;
		}
	}
	alert("Please finish all the required steps..");
	return false;
}

function changebg(imgid, imgsrc){
	document.getElementById(imgid).src = "images/"+imgsrc;
}
</script>

</head>
<body>
<table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><%@ include file="/modules/headers/header4.jsp" %></td>
  </tr>
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="1" rowspan="3" bgcolor="#122222"></td>
        <td rowspan="2" valign="top" style="padding:0px 5px 5px 5px; color: #333; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">
<!--<form id="tutorialSelectionForm" method="post" action="TutorialSelectionServlet">-->
<form id="tutorialSelectionForm" name="tutorialSelectionForm" method="post" 
	onsubmit="return isReady(this)" action="SaveSelectionsServlet">
<div id="divMain">
<%
int currentIndex = Integer.parseInt(request.getParameter("index"));
System.out.println("curr_ind: " + currentIndex);
session.setAttribute("currentIndex", currentIndex);
System.out.println("TUTSEL: 1");
ArrayList<String> approvalList = (ArrayList<String>) session.getAttribute("approvalList");
ArrayList<List<String>> wordsList = (ArrayList<List<String>>) session.getAttribute("wordsList");
ArrayList<Integer> difficultyList = (ArrayList<Integer>) session.getAttribute("difficultyList");
ArrayList<Tutorial> tutorialList = (ArrayList<Tutorial>)session.getAttribute("tutorialList");
//ArrayList<String> tutorialDescriptionList = (ArrayList<String>)session.getAttribute("tutorialDescriptionList");
ArrayList<HashMap<String, ArrayList<String>>> hintsMapList = (ArrayList<HashMap<String, ArrayList<String>>>)session.getAttribute("hintsMapList");

Tutorial currentTutorial = tutorialList.get(currentIndex);
%>

<table><tbody><tr>
<%
System.out.println("TUTSEL: 2");
for (int i = 0; i < tutorialList.size(); i++) {
	String tutorialSelectionClass = (i==currentIndex) ? "active" : "passive";
	out.print("<td class=" + tutorialSelectionClass);
	out.print(" onclick=\"window.location.href='tutorialSelection.jsp?index=");
	out.print(i);
	out.print("'\"");
	out.print("><div>Snippet# " + (i+1));
	out.print("</div><div><image src=\"images/tick.png\" class=\"");
	if (approvalList.get(i) != null) {
		out.print("showimage");
	}
	else {
		out.print("noimage");
	}
	
	out.println("\"/></div></td>");
}
%>
</tr></tbody></table>	

<div id="divStepsContainer">
<div id="divApproveSample" class="stepBox">
<div class="step">STEP 1</div>
<fieldset>
<label>What would you like to do with the following Snippet?</label><br />

<%
System.out.println("TUTSEL: 3");
String approvalSelected = approvalList.get(currentIndex);
String[] approvalOptions = {"Quiz", "Example", "Discard", "Edit"};
for (int approvalIndex = 0; approvalIndex <= 3; approvalIndex++) {
	out.print("<input type=\"radio\" name=\"radioApproval\" value=\""); 
	out.print(approvalOptions[approvalIndex]);
	out.print("\"");
	if (approvalSelected != null) {
		if (approvalSelected.equals(approvalOptions[approvalIndex])) {
			out.print(" checked=\"checked\"");
		}
	}
	out.print("/>");
	out.println(approvalOptions[approvalIndex]);
}
%>

<div id="divEditButton">
<input id="btnEdit" value="Edit the snippet" name="btnSubmit" type="submit" onclick="setSubmit('Edit')" />
</div>

</fieldset>
<fieldset>
    <label>Enter a Description for this Quiz/Tutor</label>
    <textarea name="exDescription" id="exDescription" style="height:75px; width:100%" ><% if(currentTutorial.getTutorialDescription() != null){ out.print(currentTutorial.getTutorialDescription()); } %></textarea>
</fieldset>
</div>

<div id="divWordInfo" class="stepBox">
<div class="step">STEP 2</div>
<fieldset>
<label>Select the words to blank:</label><br />
<%
int index = 0;
System.out.println("TUTSEL: 4");
List<String> selectedWords = wordsList.get(currentIndex);
for (WordInfo currentWordInfo : currentTutorial.getWordInfoList()) {
	out.print("<input type=\"checkbox\" name=\"cbxWordInfo\" value=\"" + index + "\" id=\"cb_" + index + "\"");
	if(selectedWords != null) {
		if (selectedWords.contains(Integer.toString(index))) {
			out.print(" checked=\"checked\"");
		}
	}
	out.println(" />");
	out.println("<label id=\"" + index + "\" for=\"cb_" + index + "\">" + currentWordInfo.wordToBeBlanked + " : ");
	out.println("<span class=\"lineNumber\">Line:" + currentWordInfo.lineNumber + "</span>");
	out.println("</label><br />");
	index++;
}
%>
<label>Looking for a different word?</label> <span class="lineNumber" id="spanChange">Click to add more</span></br>
<%
String wordFound = request.getParameter("wordFound");
String display = "none";
if (wordFound != null) {
	if (wordFound.equalsIgnoreCase("false")) {
		display = "block";
	}
}
%>
<span id="wordFound" style="display:<%= display%>; color:red;">*Word not found..</span>
<div class="divInvisibleNewWord" id="divNewWord" style="display: none; ">
<input type="text" name="txtNewWord" placeholder="Word 1, Word 2, ...(comma separated)" value="" size="50">
<br/>
<input type="submit" name="btnSubmit" id="btnSaveNewWord" value="Verify & Save" onclick="setSubmit('newWord')"/>
<span id="cancelChange">&nbsp;&nbsp;<b>X</b> Cancel&nbsp;&nbsp;</span>
<div id="divNewWordNote">
Note: You can have only 1 word per line in the quiz. If you want to blank a word that exists on the line that contains a suggested word, then the suggested word will be lost.
</div>
</div>

<label for="cbxWordInfo" class="error">Required Field. If none are useful mark "NO" in STEP 1.</label>
</fieldset>
</div>
<div id="divRating" class="stepBox">
<div class="step">STEP 3</div>
<fieldset>
	<label>Rate the difficulty level of this snippet:</label><br />
	<%
	System.out.println("TUTSEL: 5");
	Integer difficultySelected = difficultyList.get(currentIndex);
                out.print("<table align=\"center\"><tr>");
		for (int difficultyIndex = 1; difficultyIndex <=5; difficultyIndex++) {
			out.print("<td><table><tr><td><input name=\"difficultyLevel\" type=\"radio\" value=\"" + difficultyIndex + "\" class=\"star\"");
			if (difficultySelected != null) {
				if (difficultySelected == difficultyIndex) {
					out.print(" checked=\"checked\"");
				}
			}
			out.println("/></td></tr><tr><td>" + difficultyIndex + "</td></tr></table></td>");
		}
                out.print("</tr><tr><td align=\"center\" colspan=\"5\"><-easiest -------- hardest-></td></tr></table>");
	%>
</fieldset>
</div>
</div>

<div id="divSubmit">
<input type="submit" name="btnSubmit" id="btnSubmitPrev" onclick="setSubmit('Prev')" 
<%
if (currentIndex == 0) {
	out.print(" disabled=\"disabled\" ");
}
%>
	value="<< Previous Snippet" />

<input type="submit" name="btnSubmit" id="btnSubmitNext" onclick="setSubmit('Next')"
	value="Next Snippet >>" />
</div>

<div id="divCode">
<table>
<tr><td>
<div id="divCodeTable">
<table>
<tbody>
<tr><td class="tdSmall"></td><td class="copyright">To read more about this snippet visit: 
<a href="
<% out.println(currentTutorial.getUrl().replaceFirst("^\\d*", "")); %>
" target="_blank" >^ link.</a>
</td></tr>
<%
System.out.println("TUTSEL: 6");
for (index = 1; index <= currentTutorial.getLinesOfCode().size(); index++) {
	String className = (index%2==0) ? "even" : "odd";
	out.println("<tr><td>");
	out.print("<span class=\"lineNumber\">" + index + "</span>");
	out.println("</td><td class=\"" + className + "\">");
	out.print(currentTutorial.getLinesOfCode().get(index-1));
	out.println("</tr></td>");
}
%>
</tbody>
</table>
</div>
</td>
<td id="tdHintCell">
<div id="divHint">
<div class="step">STEP 4</div> Hints Corresponding to : 
<% 
HashMap<String, ArrayList<String>> hintsMap = hintsMapList.get(currentIndex);
int currWordInfoIndex = 0;
System.out.println("TUTSEL: 7");
for (WordInfo currentWordInfo : currentTutorial.getWordInfoList()) {
	String wordToBeBlanked = currentWordInfo.wordToBeBlanked;
	ArrayList<String> currHintsList = null;
	String hintValue = "";
	if (hintsMap != null) {
		currHintsList = hintsMap.get(Integer.toString(currWordInfoIndex));
	}
	out.println("<div class=\"divInvisibleHint\" id=\"divHint" + currWordInfoIndex + "\"> ");
	out.println(wordToBeBlanked);
	boolean lastHintPassed = false;
	for (int hintIndex = 1; hintIndex <= 2; hintIndex++) {
		if (currHintsList != null ) {
			if (currHintsList.size() > 0) {
				hintValue = currHintsList.get(0);
				currHintsList.remove(0);
				if (hintValue.equalsIgnoreCase(wordToBeBlanked)) hintValue = "";
			}
		}
		out.println("<br /><input type=\"text\" " +
				"name=\"txtHint_" + currWordInfoIndex + "_" + hintIndex + "\" " + 
				"placeholder=\"Hint " + hintIndex + "\" " + 
				"value=\"" + hintValue + "\" " +
				"size=\"30\" " +
				" />");		
	}
	out.println("</div>");
	currWordInfoIndex++;
}
%>
</div>
</td>
</tr>
</table>
</div>

<div id="divMessages">
Any questions about this snippet? Problems in adding new words even though the word is visible in the snippet? Check out what Java compiler has to say about this code by clicking here: <span class="lineNumber" id="toggleMessage">Toggle compiler messages</span>
<div id="compilerMessages">
<%
if (currentTutorial.getFacade().getMessages().length > 0) {
	for (Message currMessage : currentTutorial.getFacade().getMessages() ) {
		out.println("At char: " + currMessage.getStartPosition() + "::" + currMessage.getMessage() + "<br />");
	}
}
else {
	out.println("<span class=\"lineNumber\">No compiler messages..</span>");
}
%>
<hr />
<span class="lineNumber">Compiler modifies the snippet as follows:</span>
<pre>
<%= currentTutorial.getFacade().getInterpretedCode() %>
</pre>
</div>
</div>

</div>
</form>
<td width="1" rowspan="3" bgcolor="#122222"></td>
</td>
</tr>
</table>
</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#122222"></td>
  </tr>
</table>
</body>
</html>