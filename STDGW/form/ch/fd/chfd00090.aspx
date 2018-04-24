<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
function BodyInit()
{/*
    var i=0;
    for(i=0;i<15;i++)
    idGrid.AddRow(); 
    idGrid.GetGridControl().MergeCells =5	;
    idGrid.GetGridControl().MergeRow(0)=true;
    idGrid.GetGridControl().Cell(0,1,0,1,0)="Congratulations";   //.Cell(0,row, from_col, row, to_col)	
    idGrid.GetGridControl().Cell(0,4,0,4,0)="Condolences";   //.Cell(0,row, from_col, row, to_col)	
    /**/
    idGrid.AddRow(); 
}

</script>
<body >
<!-------------------data control----------------------->

<table style=" width:100%">
    <tr>
        <td style="width:20%; font-family:Tahoma; font-size:medium" colspan=2 align=left>Applicant</td>
        <td colspan=6 style=" width:80%"></td>
    </tr>
    <tr>
        <td style="width:15%" align="center">EMP ID</td>
        <td style="width:10%"><gw:textbox id="txtEMP_ID" onenterkey   ="" styles='width:100%'/></td>
        <td style="width:10%" align="center">Name</td>
        <td style="width:10%"><gw:textbox id="txtName" onenterkey   ="" styles='width:100%'/></td>
        <td style="width:10%" align="center">Location</td>
        <td style="width:10%"><gw:textbox id="txtLocation" onenterkey   ="" styles='width:100%'/></td>
        <td style="width:10%" align="center">Department</td>
        <td style="width:10%"><gw:textbox id="txtDepartment" onenterkey   ="" styles='width:100%'/></td>
    </tr>
    <tr>
        <td colspan=5></td>
        <td align="center">
                           
        </td>
        <td align="center">
                                   
        </td>
        <td align="center">
            <gw:icon id="idBtnUpdate" img="in" text="Confirm" onclick="" />                        
        </td>
    </tr>
</table>    
<table style="width:100%">
    <tr>
        <td style="font-family:Tahoma; font-size:medium; width:15%">Application</td>
    </tr>
    <tr>
        <td style="width:15%">Date</td>
        <td style="width:15%" colspan=2><gw:datebox id="dtDate" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/></td>        
        <td style="width:10%"></td>      
        <td style="width:15%">Applied Date</td>        
        <td style="width:15%" colspan=2><gw:textbox id="txtApplied_Date" onenterkey   ="" styles='width:50%'/></td>        
        <td style="width:15%"></td>              
    </tr>
    <tr>
        <td style="width:15%">Benificial</td>
        <td style="width:5%"><gw:textbox id="txtEMP_ID_1" onenterkey   ="" style='width:100%'/></td>        
        <td style="width:10%"><gw:textbox id="txtEMP_Name_1" onenterkey   ="" style='width:100%'/></td> 
        <td style="width:15%" align="center">
            <gw:icon id="idBtnUpdate" img="in" text="Change Beneficiary" onclick="" />                        
        </td>
        <td style="width:15%" >Approver</td>        
        <td style="width:15%" colspan=2><gw:textbox id="txtApprover" onenterkey   ="" styles='width:50%'/></td>        
        <td style="width:15%"><gw:icon id="idBtnUpdate" img="in" text="Change Approver" onclick="" />                        </td>              
    </tr>
    <tr>
        <td style="width:15%">Type</td>
        <td style="width:15%">
            <gw:datebox id="dtType" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/>
        </td>        
        <td style="width:15%" colspan=2></td>
        <td style="width:15%">Join Date</td>        
        <td style="width:15%" colspan=2><gw:textbox id="txtJoinDate" onenterkey   ="" styles='width:50%' /></td>                        
        <td style="width:15%"></td>              
    </tr>
    <tr>
        <td style="width:15%">Leave</td>
        <td style="width:15%">
            <gw:textbox id="txtLeave" onenterkey   ="" styles='width:100%' />
        </td>        
        <td style="width:15%" colspan=2>Days</td>
        <td style="width:15%">Period</td>        
        <td style="width:10%" >
            <gw:datebox id="dtFrom" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/>
        </td>              
        <td style="width:15%" align=center> ~ </td>
        <td style="width:15%">
            <gw:datebox id="dtTo" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/>
        </td>              
    </tr>
    <tr>
        <td style="width:15%">Amount</td>
        <td style="width:15%">
            <gw:textbox id="txtExpenseAmount" onenterkey   ="" styles='width:100%' />
        </td>        
        <td style="width:15%" colspan=2>VND</td>
        <td style="width:15%">Bank Account</td>        
        <td style="width:15%">
            <gw:list  id="lstDept_Code" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeDept()">
                <data>|ALL|Beneficiary</data>
            </gw:list>
        </td>                        
        <td style="width:15%">
            <gw:textbox id="txtBankAccount" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/>
        </td>              
    </tr>
</table>
<table style="width:100%; height:30%">
    <tr>
        <td style="font-family:Tahoma; font-size:medium">Summary of Application</td>
    </tr>
    <tr style="width:100%; height:100%">
        <td>
            <gw:grid
					    id="idGrid"
					    header="Benificiary|Date|Type|Amount|Applied date|Appliant|Status"
					    format="0|0|0|0|0|0|0"
					    aligns="0|1|1|1|1|1|1"
					    defaults="|||||||"
					    editcol="0|0|0|0|0|0|0"
					    widths="2500|2000|2000|2000|2000|2000|2000"
					    styles="width:100%;height:100%"
					    sorting="F"
					    onafteredit=""
					    oncellclick = ""
					    acceptNullDate="T"
					    oncelldblclick = ""/>            
        </td>
    </tr>
</table>
<table style="width:100%; height:10%">
    <tr>
        <td width="42%" align=right>
         <gw:icon id="idBtnUpdate"  img="in" text="Save" onclick="" /> 
        </td>
        <td width="5%">
         
        </td>
        <td width="43%" align=left>
         <gw:icon id="idBtnUpdate"  img="in" text="Submit" onclick="" /> 
        </td>
    </tr>
    
</table>
<!----------------------------------->

</body>
</html>
