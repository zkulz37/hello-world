<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Project</title>
</head>
<%  ESysLib.SetUser("EC111")%>
<script>
var G_pk=0,
	G_Budget_Item_Code=1,
	G_Budget_Item_name=2,
	G_name=3,
	G_Currency=4,
	G_Unit_Original=5,
	G_Qty_Original=6,
	G_Unit_Price_Original=7,
	G_Amount_Original=8,
	G_Actual_Rsl_Amt_B=9,
	G_Wkg_Bal=10,
	G_Unit_Wkg_Changed=11,
	G_Qty_Wkg_Changed=12,
	G_Unit_Price_Wkg_Changed=13,
	G_Amount_Wkg_Changed=14,
	G_Incr_Decr=15,
	G_Exec_YN=16,
	G_Calc_Basis=17,
	G_Project_pk=18,
	G_BudgetNo=19,
	G_BudgetItem_PK=20;
function BodyInit()
{
        System.Translate(document);
	    MergeHeader();
		Grid_Mst.GetGridControl().FrozenCols = 3;
		<%=ESysLib.SetGridColumnComboFormat("Grid_Mst", 4,"SELECT A.CODE, A.CODE_nm FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;//ccy 
}  
//============================================================================================
function MergeHeader()
{
        var fg=Grid_Mst.GetGridControl(); 	
        if(fg.Rows < 2)
		{
		   Grid_Mst.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 5, 0, 8)  = "Working[Original](A)"   
		fg.Cell(0, 1, 5, 1, 5) = "Unit"
	    fg.Cell(0, 1, 6, 1, 6) = "Q'ty"
	    fg.Cell(0, 1, 7, 1, 7) = "Unit Price" 
		fg.Cell(0, 1, 8, 1, 8) = "Amount" 
		
		fg.Cell(0, 0, 11, 0, 14)  = "Working[Changed](D)"   
		fg.Cell(0, 1, 11, 1, 11) = "Unit"
	    fg.Cell(0, 1, 12, 1, 12) = "Q'ty"
	    fg.Cell(0, 1, 13, 1, 13) = "Unit Price" 
		fg.Cell(0, 1, 14, 1, 14) = "Amount" 
	    
	
	    fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "PK"	
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Budget Item Code"	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Budget Item Name"	
	    fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Name"	
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 4) = "Currency"
		
		fg.MergeCol(9) = true
		fg.Cell(0, 0, 9, 1, 9) = "Actual Result Amount(B)"
		
		fg.MergeCol(10) = true
		fg.Cell(0, 0, 10, 1, 10) = "Wkng Bal. (C=A-B)"
		
		fg.MergeCol(15) = true
		fg.Cell(0, 0, 15, 1, 15) = "Incr./Decr. (E=D-A)"
		fg.MergeCol(16) = true
		fg.Cell(0, 0, 16, 1, 16) = "Exec. (Y/N)"
		
		fg.MergeCol(17) = true
		fg.Cell(0, 0, 17, 1, 17) = "Calc. Basis"
		
} 
//============================================================================================
function OnPopUp(obj)
{
        switch(obj)
        {
				case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
									dso_BudgetNo.Call();
                            } 
                break;
		}
}
function OnSearch()
{
	dso_kpda00050.Call("SELECT");
}
function CheckValidate()
{
    for(var i=2;i<Grid_Mst.rows;i++)  
          {
            if(Grid_Mst.GetGridData(i,G_Budget_Item_Code) == "" || Grid_Mst.GetGridData(i,G_Budget_Item_name) == "")
             {
                alert("Please, input budget item code ,item name at row "+ (i-1));
                return false;
             }
          }
          return true;
}
function OnAddNew()
{
	if(txtProject_Pk.text !="")
	{
		Grid_Mst.AddRow();
		Grid_Mst.SetGridText(Grid_Mst.rows -1, G_Project_pk, txtProject_Pk.text);
		Grid_Mst.SetGridText(Grid_Mst.rows -1, G_BudgetNo, lstStatementNo.value);
	}
	else
	{
		alert("Please,choose project to add new.");
	}
}
function OnSave()
{
	if(CheckValidate())
	{
		Grid_Mst.SetRowStatus(1, 0x00);
		dso_kpda00050.Call();
	}
}
function OnDelete()
{
	if(confirm('Are you sure you want to delete ?'))
	{
			Grid_Mst.DeleteRow();
			dso_kpda00050.Call();	
	}
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_kpda00050')
	{
		MergeHeader();
	}
}
function OnBudgetPopup()
{
	if(Grid_Mst.col=='1' || Grid_Mst.col=='2')
	{
		var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx";
		var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
		if(object != null)
		{
			Grid_Mst.SetGridText(Grid_Mst.row, G_BudgetItem_PK,object[0]);
			Grid_Mst.SetGridText(Grid_Mst.row, G_Budget_Item_Code,object[1]);
			Grid_Mst.SetGridText(Grid_Mst.row, G_Budget_Item_name,object[2]);
			
		}
	}
}
//not yet,I waiting 2.1.8
</script>
<body>
<gw:data id="dso_kpda00050" onreceive="OnDataReceive(this)">
    <xml>
        <dso type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="ec111.sp_sel_kpda00050" procedure="ec111.sp_upd_kpda00050" >
            <input bind="Grid_Mst">
                <input bind="txtProject_Pk"/>
                <input bind="lstStatementNo"/>
            </input>
            <output bind="Grid_Mst"/>
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_BudgetNo" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="ec111.sp_sel_kpbm00050_budgetno" > 
			<input> 
				<input bind="txtProject_Pk" />
			</input> 
			<output>
				<output bind="lstStatementNo" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>

    <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height:2%;width:100%">
                        <td>
                            <fieldset style="width:100%;padding:0">
                                <table  style="width: 100%" cellpadding="1" cellspacing="1">
                                            <tr>
                                                        <td align="right" width="10%">
                                                            <a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">
                                                                Project&nbsp;</a></td>
                                                        <td width="45%">
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
                                                        <td width="15%" align="right">Budget No&nbsp;</td>
                                                                <td width="25%"><gw:list id="lstStatementNo" styles='width:100%' /></td>
                                                        <td width="5%"></td>
                                                        <td ><gw:imgbtn id="btCopyData" img="copy" alt="Copy Standard Expenses"  onclick="" /></td>
                                                        <td ><gw:imgbtn id="btSearch" img="search" alt="Search"  onclick="OnSearch()" /></td>
                                                        <td ><gw:imgbtn id="btNew" img="new" alt="New"  onclick="OnAddNew()" /></td>
                                                        <td ><gw:imgbtn id="btSave" img="save" alt="Save"  onclick="OnSave()" /></td>
                                                        <td ><gw:imgbtn id="btDelete" img="delete" alt="Delete"  onclick="OnDelete()" /></td>
                                            </tr>    
                                            <tr >
                                            			<td></td>
                                                        <td></td>
                                                        <td width="" align="right">Total&nbsp;</td>
                                                        <td width="" colspan="7"><gw:list id="lstTotal" styles='width:100%' /></td>
											</tr>       
                                </table>
                            </fieldset>
                        </td>
                    </tr>
					
                    <tr style="height: 96%">
						   <td width="100%">
								<gw:grid 
								id="Grid_Mst"  
								header="_0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|_Project_pk|_budget_no|_budget_item_pk"   
								format="0|0|0|0|0|0|-0|-0|-0|-0|-0|0|-0|-0|-0|-0|3|0|0|0|0"  
								aligns ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
								defaults="||||||||||||||||||||"  
								editcol="1|0|0|1|1|1|1|1|0|1|1|1|1|1|0|0|1|1|1|1|1"  
								widths  ="1000|1600|2700|2000|1500|1500|1500|1500|1500|2200|1650|1500|1500|1500|2000|2400|1500|1500|0|0|0"  
								styles="width:100%; height:100%"   
								sorting="T"   
								oncelldblclick= "OnBudgetPopup()" /> 
						  </td>
                    </tr>
   </table>
</body>
</html>
