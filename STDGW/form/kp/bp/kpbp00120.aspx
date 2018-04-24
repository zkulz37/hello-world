<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Main Contract Other Expenses</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
function BodyInit()
{
      System.Translate(document);
      BindingDataList();
    
}
//=============================================================================================
function BindingDataList()
{
        //<%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0009' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;
        <%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
        <%=ESysLib.SetGridColumnComboFormat("Grid_Detail2", 3,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
//        <%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0010' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>; 
//        <%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0011' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
//		<%=ESysLib.SetGridColumnComboFormat("Grid_Detail", 2,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0017' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Work_Breakdown':
                            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown_1.aspx';
		                    var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
		                    if ( obj != null )
		                    {
                                        if (obj[0] != 0)
                                        {
                                            lstWork_Breakdown.SetDataText(obj[0]);
                                        }   
                            }
                break;
                case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Project.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
                            } 
                break;
                case 'Filter':
                
                break;
                case 'Version':
                            if(txtProject_Pk.text == '')
                            {
                                    alert('Please select Project !!');
                            }
                            else
                            {
                                        var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Version.aspx?Project_Pk=" + txtProject_Pk.text;
                                        var aValue = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                                        if(aValue != null)
                                        {
                                                txtVersion_Pk.text = aValue[0];
                                                txtVersion_Cd.text = aValue[1];
                                        } 
                            } 
                break;
        }
} 
//==================================================================================================
function OnSearch()
{
    if(txtProject_Pk.text=="")
    {
        alert("Please select Project to Search");
    }
    else
    {
        data_kpbp00120.Call("SELECT");
    }
    
}
//==========================================================================================
function OnDelete()
{
    if(Grid_Detail2.row>0)
    {
        if(Grid_Detail2.GetGridData(Grid_Detail2.row,0)!="")
        {
            Grid_Detail2.DeleteRow();
        }
        else
        {
            Grid_Detail2.RemoveRow();
        }
    }
}
//===========================================================================================
function OnUnDelete()
{
    Grid_Detail2.UnDeleteRow();;
}
//==========================================================================================
function OnSave()
{
    data_kpbp00120_1.Call();
}
//===========================================================================================
function OnAddNew()
{
    if(txtProject_Pk.text==""||Grid_Detail.rows<2)
    {
        alert("Please Select Project First !!!");
    }
    else
    {---------------------
        Grid_Detail2.AddRow();
        Grid_Detail2.SetGridText(Grid_Detail2.rows-1,6,txtProject_Pk.text);
    }
    
    
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
     switch(obj.id)
     {
        case "data_kpbp00120":
            if(Grid_Detail.rows>1)
            {
            Grid_Detail.Subtotal( 0, 2, -1, '3!4!5!6!7','###,###,##0.##0');  
            Grid_Detail.SetGridText(Grid_Detail.rows-1,1,'TOTAL');
            data_kpbp00120_1.Call("SELECT");
            }
        break;
        case'data_kpbp00120_1':
            var total=0;
            for(i=1;i<Grid_Detail2.rows;i++)
            {
                total=total+Number(Grid_Detail2.GetGridData(i,4));
            }
            Grid_Detail.SetGridText(Grid_Detail.rows-1,6,total);
            var sum=0
            for (j=1;j<Grid_Detail.rows-1;j++)
            {
                sum=sum+(Number(Grid_Detail.GetGridData(j,3))+Number(Grid_Detail.GetGridData(j,4))+Number(Grid_Detail.GetGridData(j,5))+Number(Grid_Detail.GetGridData(j,6)));
            }
            Grid_Detail.SetGridText(Grid_Detail.rows-1,7,sum+total);
        break;
	 }
}		 
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_kpbp00120" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid"  function="ec111.sp_sel_kpbp00120" >
                <input bind="Grid_Detail" >
                    <input bind="txtProject_Pk" />
                </input>
                <output bind="Grid_Detail" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_kpbp00120_1" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid"  function="ec111.sp_sel_kpbp00120_1" parameter="0,1,2,3,4,5,6" procedure="ec111.sp_upd_kpbp00120_1">
                <input bind="Grid_Detail2" >
                    <input bind="txtProject_Pk" />
                </input>
                <output bind="Grid_Detail2" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
        <tr style="height: 4%">
            <td>
                <fieldset>
                    <table style="width: 100%">
                        <tr>
                            <td align="left" width="9%">
                                <a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('Project')">
                                    Project</a></td>
                            <td width="70%">
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
                            <td width="30%">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="40%">
                                        </td>
                                        <td width="1%" align="right">
                                            <gw:imgbtn id="ibSearch" img="search" onclick="OnSearch()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 50%">
            <td colspan="4">
                <gw:grid id='Grid_Detail' header='_PK|Work|Currency|Material Cost|Labor Cost|Expenses|legally Allowed Expenses|Sum'
                    format='0|0|0|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0' check='|||||||' editcol='1|1|1|1|1|1|1|1'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' />
            </td>
        </tr>
        <tr style="height: 1%">
            <td width="30%" colspan="4">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="40%">
                        </td>
                        <td width="1%" align="right">
                            <gw:imgbtn id="ibAddNew" img="new" alt="Add new" onclick="OnAddNew()" />
                        </td>
                        <td width="1%" align="right">
                            <gw:imgbtn id="ibDelete" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td width="1%" align="right">
                            <gw:imgbtn id="ibtnUpdte" img="Udelete" alt="Undelete" onclick="OnUnDelete()" />
                        </td>
                        <td width="1%" align="right">
                            <gw:imgbtn id="ibUpde" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%">
            <td colspan="4">
                <gw:grid id='Grid_Detail2' header='_PK|Legally Allowed Expenses Item|Formula|Currency|Amount|Remark|_Project_pk'
                    format='0|0|0|0|1|0|0' aligns='0|0|0|0|0|0|0' check='||||||' editcol='1|1|1|1|1|1|1'
                    widths='1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
</html>
