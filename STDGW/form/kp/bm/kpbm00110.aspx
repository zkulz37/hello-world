<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Work Division Entry</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script language="javascript">
function BodyInit()
{
	System.Translate(document);
	MerGrid();
}
//============================================================================================
function OnNew()
{
	Grid_WorkDivision.AddRow();
}

//============================================================================================
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
		fg.Cell(0, 0, 0, 1, 0) = "Work Description"
		
        fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Level Work Division"
	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Order Work Division"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 3, 0, 7) = "Contract Amount"  
		fg.Cell(0, 1, 3, 1) 	= "Currency"
		fg.Cell(0, 1, 4, 1 ) 	= "Raw Mtrl. Cost"
		fg.Cell(0, 1, 5, 1) 	= "Labor Cost"
		fg.Cell(0, 1, 6, 1) 	= "Expenses"
		fg.Cell(0, 1, 7, 1) 	= "Amount"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 8, 0, 12) = "Budget Cost of Work Schedule(BCWS)"  
		fg.Cell(0, 1, 8, 1) 	= "Currency"
		fg.Cell(0, 1, 9, 1 ) 	= "Raw Mtrl. Cost"
		fg.Cell(0, 1, 10, 1) 	= "Labor Cost"
		fg.Cell(0, 1, 11, 1) 	= "Expenses"
		fg.Cell(0, 1, 12, 1) 	= "Amount"	
}
var f_lag="1";
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {   
                                    f_lag="1";
									txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
									dso_BudgetNo.Call("SELECT");
                            } 
                break;
        }
} 
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
         switch(obj.id)
         {
                case "dso_Search":
                         MerGrid();
                break;
		 }
}
function OnSearch()
{
		if(txtProject_Pk.text !="")
		{
			dso_Search.Call('SELECT');
		}
		else
		{
			alert("Please,choose project to search.");
		}
}	
//============================================================================================

</script>

<body>
	<gw:data id="dso_BudgetNo" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="ec111.sp_sel_kpbm00050_budgetno" > 
			<input> 
				<input bind="txtProject_Pk" />
			</input> 
			<output>
				<output bind="lstBudget" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_Search" onreceive="OnDataReceive(this)">
	  <xml>
		<dso type="grid"  function="ec111.sp_sel_kpbm00110" >
		  <input bind="idGrid">
			  <input bind="txtProject_Pk"/>
			  <input bind="lstBudget"/>
		  </input>
		  <output bind="idGrid"/>
		</dso>
	  </xml>
</gw:data>
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 2%">
        		<td width="100%">
                		<fieldset style="padding:0">
                        			<table cellpadding="0" cellspacing="0" width="100%">
                                    		<tr>
                                            			<td align="right" width="10%">
                                                                    <a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">
                                                                        Project&nbsp;</a></td>
                                                                <td width="40%">
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
                                                                <td style="white-space: nowrap; width: 15%" align="right">
                                                                    Budget No&nbsp;
                                                                </td>
                                                                <td style="width: 35%">
                                                                    <gw:list id="lstBudget" styles='width:100%' />
                                                                </td>
                                                                <td>
                                                                    <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                                                                </td>
                                                                                                </tr>
                                                                                        </table>
                        </fieldset>
                </td>
        </tr>
      
        <tr style="height: 98%">
            <td width="100%" colspan="6">
                <gw:grid id="idGrid" 
                header="Work Description|Level Work Division|Outside Order Work Type|Currency|Material Cost|Labor Cost|Expenses|Amount|Currency|Material Cost|Labor Cost|Expenses|Amount"
                    format="0|0|0|0|-0|-0|-0|-0|0|-0|-0|-0|-0" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="||||||||||||" editcol="0|1|1|1|1|1|1|1|1|1|1|1|1" widths="1700|1700|1800|1800|2400|2300|1000|1000|1000|1400|1000|1000|1000"
                    styles="width:100%; height:100%" sorting="T" />
            </td>
        </tr>
    </table>
</body>
</html>
