<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Divide Main Contract Detail</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
  System.Translate(document);
  idGrid.GetGridControl().WordWrap = true;
  MerGrid()
  
}
//-------------------------------------------
function OnSearch()
{
    
	
}
//-------------------------------------------
function MerGrid()
{
    if (idGrid.rows < 2)
		{
			
			idGrid.AddRow();
		}
	var fg=idGrid.GetGridControl();
		fg.FixedRows = 2
		fg.MergeCells = 5

		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Budget Item"
		
	    fg.MergeRow(0) = true
		fg.Cell(0, 0, 1, 0, 1) = "BCWS (Adj. Appr. Req. Incl.)"  
		fg.Cell(0, 1, 1, 1) 	= "(A)"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 2, 0, 2) = "Input Amt"  
		fg.Cell(0, 1, 2, 1) 	= "(B)"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 3, 0, 3) = "Exec. Rate"  
		fg.Cell(0, 1, 3, 1) 	= "(B/A)"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 4, 0, 4) = "Balance of Budget"  
		fg.Cell(0, 1, 4, 1) 	= "(C=A-B)"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 5, 0, 5) = "Cost Estimation to completion"  
		fg.Cell(0, 1, 5, 1) 	= "(E)"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 6, 0, 6) = "Cost at Completion"  
		fg.Cell(0, 1, 6, 1) 	= "(B+E)"


		
		
}
//-------------------------------------------
function OnSelect()
{
    

    
}

</script>

<body>
    <!------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 6%">
            <td width="100%" >
            		<fieldset style="padding:0">
                <table style="width: 100%; height: " border="0">
                	
                    <tr >
                        <td align="right" width="10%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">Project&nbsp;</a></td>
                         <td width="60%">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="40%">
                                            <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                                        </td>
                                        <td width="60%">
                                            <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                                        </td>
                                        <td width="">
                                            <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                                        </td>
                                    </tr>
                                </table>
                            </td>

                        <td style="width: 10%; white-space: nowrap" align="right">
                            <a title="Contract Period" style="color:#333">Cont. Per.</a>
                        </td>
                        <td style="width: 20%" align="left" >
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                        </td>
                        <td style="width:" colspan="2">
                        		<table>
                                		<tr>
                                        			<td width="100%"></td>
                                        			 <td ><gw:imgbtn id="ibtnAdd" img="new" alt="New" /></td>
                                                    <td ><gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" /></td>
                                                    <td ><gw:imgbtn id="ibtnSearch" img="search" alt="Search" /></td>
                                                    <td ><gw:imgbtn id="ibtnSave" img="save" alt="Save" /></td>
                                                    <td ><gw:imgbtn id="ibtnCancel" img="cancel" alt="Close" /></td>
                                        </tr>
                                </table>
                        </td>
                    </tr>
                   <tr>
                   			<td style="width: " align="right"><a title="Base Year/Month" style="color:#333">Basis Yr/Mth</a></td>
                            <td>
                            		<table cellpadding="0" cellspacing="0">
                                    		<tr>
                                            			<td style="width:" ><gw:datebox id="dtYear" lang="1" type="month" styles="width:100%" /></td>
                                                        <td style="width:100% " align="right"><a title="Final Account Closing Year / Month" style="color:#333">Fin. Acct. Close. Yr/ Mth&nbsp;</a></td>
                                                        <td style="width:" ><gw:datebox id="dtMonth" lang="1" type="month" styles="width:100%" /></td>
                                                       
                                            </tr>
                                    </table>
                            </td>
                            <td style="width: " align="right"><a title="Working Period" style="color:#333">Wkng Per.</a></td>
                            <td style="width: " >
                            <gw:datebox id="dtBudFromDate" lang="1" styles="width:100%" />
                            ~<gw:datebox id="dtBudToDate" lang="1" styles="width:100%" />
                        </td>
                         <td style="width:20%" align="right">Appr. Status&nbsp;</td>
                         <td style="width: 30%" ><gw:textbox id="lbStatus" styles="width:100%" /></td>
                   </tr>
                    
                </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 94%">
                        <td colspan="8">
                            <gw:grid id="idGrid" header="Budget Item|Budget Amount|Input Cost|Input Cost/Budget Amount|Balance of Budget|Cost Estimation to completion|Cost at Completion"
                                format="0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0" defaults="||||||" editcol="0|0|0|0|0|0|0"
                                widths="1500|1600|1600|1500|1800|2800|1000" styles="width:100%; height:100%"
                                sorting="T" />
                        </td>
                    </tr>
    </table>
    <gw:textbox id="iduser_pk" styles="display:none; " />
</body>
</html>
